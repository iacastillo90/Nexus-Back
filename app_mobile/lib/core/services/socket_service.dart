import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../constants/api_constants.dart';
import '../storage/storage_service.dart';
import 'logger_service.dart';

/// 🔌 **Servicio Global de WebSockets**
///
/// Gestiona la conexión en tiempo real con el Backend de Nexus.
/// Actúa como un Singleton mantenido por Riverpod ([socketServiceProvider]).
///
/// **Responsabilidades:**
/// - Iniciar el handshake con autenticación JWT.
/// - Manejar la reconexión automática y persistencia de listeners.
/// - Emitir eventos al servidor (Chat, Notificaciones).
/// - Escuchar eventos del servidor y distribuirlos a los DataSources.
///
/// **Referencias:**
/// - Backend: `src/socket/socket.service.js`
/// - Middleware: `src/socket/auth.middleware.js`
final socketServiceProvider = Provider<SocketService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return SocketService(storageService);
});

/// 🔌 **Clase SocketService**
///
/// Envoltura robusta sobre `socket_io_client`.
class SocketService {
  final StorageService _storageService;
  IO.Socket? _socket;

  /// Registro interno de handlers para persistencia entre reconexiones.
  /// Mapea `evento` -> `lista de funciones`.
  final Map<String, List<Function(dynamic)>> _handlers = {};

  SocketService(this._storageService);

  final _connectionStatusController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  /// Verifica si el socket está actualmente conectado.
  bool get isConnected => _socket?.connected ?? false;

  /// 🔗 **Conectar al Servidor**
  ///
  /// Inicializa la conexión Socket.IO con el servidor.
  ///
  /// **Flujo:**
  /// 1. Recupera el token JWT de [StorageService].
  /// 2. Si no hay token, aborta (seguridad).
  /// 3. Configura el socket con `transports: ['websocket']` y `auth: { token }`.
  /// 4. Define los listeners base (connect, disconnect, error).
  /// 5. Re-adjunta los handlers registrados previamente ([_reattachHandlers]).
  /// 6. Llama a `socket.connect()`.
  ///
  /// **Excepciones:**
  /// - Loguea errores de conexión en [LoggerService].
  Future<void> connect() async {
    LoggerService.i('SocketService: connect() called');
    final token = await _storageService.getToken();
    
    if (token == null) {
      LoggerService.w('SocketService: No token found, cannot connect.');
      return;
    }

    if (_socket != null && _socket!.connected) {
      LoggerService.i('SocketService: Already connected.');
      return;
    }

    LoggerService.i('SocketService: Connecting to ${ApiConstants.socketUrl} with token: ${token.substring(0, 10)}...');

    try {
      _socket = IO.io(
        ApiConstants.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket', 'polling']) 
            .setPath('/socket.io')
            .disableAutoConnect()
            .setAuth({'token': token})
            .setExtraHeaders({'ngrok-skip-browser-warning': 'true'}) 
            .build(),
      );

      _socket!.onConnect((_) {
        LoggerService.i('SocketService: ✅ Connected successfully');
        _connectionStatusController.add(true);
        _reattachHandlers();
      });

      _socket!.onDisconnect((data) {
        LoggerService.w('SocketService: ❌ Disconnected. Reason: $data');
        _connectionStatusController.add(false);
      });

      _socket!.onConnectError((data) {
        LoggerService.e('SocketService: 🚨 Connection Error: $data');
        _connectionStatusController.add(false);
      });

      _socket!.onError((data) {
        LoggerService.e('SocketService: 🚨 Error: $data');
      });

      // Attach existing handlers if any were registered before connect
      _reattachHandlers();

      LoggerService.i('SocketService: Calling _socket!.connect()...');
      _socket!.connect();
    } catch (e) {
      LoggerService.e('SocketService: Exception during connect: $e');
    }
  }

  /// 🛑 **Desconectar**
  ///
  /// Cierra la conexión manualmente y libera recursos del socket.
  /// Mantiene el registro de `_handlers` por si se desea reconectar después.
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket = null;
      LoggerService.i('SocketService: Disconnected manually');
    }
  }

  /// 📤 **Emitir Evento**
  ///
  /// Envía datos al servidor a través del socket.
  ///
  /// **Parámetros:**
  /// - [event]: Nombre del evento (ej: 'send_message').
  /// - [data]: Payload del evento (Map JSON o primitivo).
  ///
  /// **Ejemplo:**
  /// ```dart
  /// socketService.emit('join_room', {'roomId': '123'});
  /// ```
  void emit(String event, dynamic data) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit(event, data);
      LoggerService.d('SocketService: Emitted $event with $data');
    } else {
      LoggerService.w('SocketService: Cannot emit $event, socket not connected');
    }
  }

  /// 👂 **Escuchar Evento**
  ///
  /// Registra un callback para cuando el servidor emita un evento específico.
  ///
  /// **Parámetros:**
  /// - [event]: Nombre del evento a escuchar (ej: 'new_message').
  /// - [handler]: Función callback que recibe los datos `(dynamic data)`.
  ///
  /// **Nota:**
  /// El handler se guarda en `_handlers` para sobrevivir a reconexiones.
  void on(String event, Function(dynamic) handler) {
    if (!_handlers.containsKey(event)) {
      _handlers[event] = [];
    }
    _handlers[event]!.add(handler);

    if (_socket != null) {
      _socket!.on(event, handler);
    }
  }

  /// 🔇 **Dejar de Escuchar**
  ///
  /// Elimina todos los listeners para un evento específico.
  /// Limpia tanto del socket activo como del registro interno.
  ///
  /// **Parámetros:**
  /// - [event]: Nombre del evento a dejar de escuchar.
  void off(String event) {
    _handlers.remove(event);
    if (_socket != null) {
      _socket!.off(event);
    }
  }

  /// 🔄 **Re-adjuntar Handlers (Interno)**
  ///
  /// Itera sobre el registro `_handlers` y vuelve a suscribir las funciones
  /// al objeto `_socket` actual. Se llama automáticamente al conectar.
  void _reattachHandlers() {
    if (_socket == null) return;
    _handlers.forEach((event, handlers) {
      for (final handler in handlers) {
        _socket!.on(event, handler);
      }
    });
  }
}
