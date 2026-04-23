import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/schemas/user_schema.dart';
import '../local/schemas/post_schema.dart';
import '../local/schemas/message_schema.dart';
import '../local/schemas/request_queue_schema.dart';
import 'logger_service.dart';

/// 💾 **Servicio de Persistencia Offline (Omnipresence)**
///
/// Gestiona la base de datos local NoSQL (Isar) y la sincronización.
/// Permite que la app funcione sin conexión a internet ("Offline-First").
///
/// **Responsabilidades:**
/// - Inicializar y mantener la instancia de Isar DB.
/// - Guardar caché de Usuarios, Posts y Mensajes.
/// - Gestionar la Cola de Peticiones ([RequestQueueSchema]) para reintentos.
///
/// **Referencias:**
/// - DB: `Isar` (Super fast NoSQL).
final offlineServiceProvider = Provider<OfflineService>((ref) {
  return OfflineService();
});

/// 💾 **Clase OfflineService**
class OfflineService {
  late Isar _isar;
  bool _isInitialized = false;

  /// 🚀 **Inicializar Base de Datos**
  ///
  /// Abre la instancia de Isar con todos los esquemas registrados.
  /// Debe llamarse antes de `runApp`.
  Future<void> initialize() async {
    if (_isInitialized) return;

    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        UserSchemaSchema,
        PostSchemaSchema,
        MessageSchemaSchema,
        RequestQueueSchemaSchema,
      ],
      directory: dir.path,
    );
    
    _isInitialized = true;
    LoggerService.i('💾 OfflineService (Isar) initialized');
  }

  /// Acceso directo a la instancia de Isar para consultas complejas.
  Isar get db => _isar;

  /// 💾 **Guardar Ítem Genérico**
  ///
  /// Persiste un objeto individual en su colección correspondiente.
  ///
  /// **Parámetros:**
  /// - [item]: Objeto anotado con `@collection` (Isar Schema).
  Future<void> save<T>(T item) async {
    await _isar.writeTxn(() async {
      await _isar.collection<T>().put(item);
    });
  }

  /// 💾 **Guardar Lista Genérica**
  ///
  /// Persiste múltiples objetos en una sola transacción (Batch).
  Future<void> saveAll<T>(List<T> items) async {
    await _isar.writeTxn(() async {
      await _isar.collection<T>().putAll(items);
    });
  }

  /// 📥 **Encolar Petición Fallida**
  ///
  /// Guarda una solicitud HTTP que falló por falta de conexión.
  /// Se reintentará cuando vuelva internet.
  ///
  /// **Parámetros:**
  /// - [method]: Verbo HTTP (POST, PUT, DELETE).
  /// - [url]: Endpoint relativo o absoluto.
  /// - [body]: Payload JSON (opcional).
  Future<void> queueRequest({
    required String method,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final request = RequestQueueSchema()
      ..method = method
      ..url = url
      ..body = body != null ? jsonEncode(body) : null
      ..createdAt = DateTime.now();

    await save(request);
    LoggerService.i('📥 Request queued: $method $url');
  }

  /// 📤 **Obtener Peticiones Pendientes**
  ///
  /// Retorna la cola de solicitudes ordenadas por antigüedad (FIFO).
  Future<List<RequestQueueSchema>> getPendingRequests() async {
    return await _isar.requestQueueSchemas.where().sortByCreatedAt().findAll();
  }

  /// 🗑️ **Eliminar Petición de la Cola**
  ///
  /// Se llama después de que una petición encolada se procesa con éxito.
  Future<void> removeRequest(int id) async {
    await _isar.writeTxn(() async {
      await _isar.requestQueueSchemas.delete(id);
    });
  }
  
  /// 🧹 **Limpiar Todo (Wipe)**
  ///
  /// Borra todos los datos locales. Útil al cerrar sesión.
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
}
