import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/services/socket_service.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/chat_datasource.dart';
import '../../data/datasources/chat_websocket_datasource.dart';
import '../../data/datasources/mentor_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/entities/mentor_entity.dart';
import '../../domain/entities/message_entity.dart';
import 'dart:async';

part 'chat_providers.g.dart';

/// ☁️ **Proveedor de DataSource REST (Chat)**
@riverpod
ChatDataSource chatDataSource(ChatDataSourceRef ref) {
  return ChatDataSource(ref.watch(networkDioProvider));
}

/// 🧠 **Proveedor de DataSource de Mentores**
@riverpod
MentorDataSource mentorDataSource(MentorDataSourceRef ref) {
  return MentorDataSource();
}

/// 🔌 **Proveedor de WebSocket (Singleton)**
///
/// Mantiene la conexión persistente del chat.
/// Se conecta automáticamente cuando el usuario se autentica.
@Riverpod(keepAlive: true)
ChatWebSocketDataSource chatWebSocketDataSource(
  ChatWebSocketDataSourceRef ref,
) {
  final socketService = ref.watch(socketServiceProvider);
  final dataSource = ChatWebSocketDataSource(socketService);

  // Auto-connect with auth token
  final authState = ref.watch(authControllerProvider);
  authState.whenData((state) {
    if (state != null) {
      dataSource.connect();
    }
  });

  // Dispose on provider disposal
  ref.onDispose(() {
    dataSource.dispose();
  });

  return dataSource;
}

/// 🔌 **Estado de Conexión del Socket**
@riverpod
Stream<bool> socketStatus(SocketStatusRef ref) {
  return ref.watch(socketServiceProvider).connectionStatusStream;
}

/// 🛡️ **Proveedor de Repositorio (Chat)**
///
/// Combina REST y WebSockets.
@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  return ChatRepositoryImpl(
    chatDataSource: ref.watch(chatDataSourceProvider),
    webSocketDataSource: ref.watch(chatWebSocketDataSourceProvider),
  );
}

/// 👥 **Lista de Mentores**
///
/// Provee la lista estática de mentores AI disponibles.
@riverpod
class Mentors extends _$Mentors {
  @override
  List<MentorEntity> build() {
    return ref.watch(mentorDataSourceProvider).getMentors();
  }
}

/// 💬 **Controlador de Mensajes de Chat**
///
/// Gestiona la lista de mensajes de una conversación específica.
/// Escucha eventos de WebSocket para actualizaciones en tiempo real.
///
/// **Argumentos:**
/// - [mentorId]: ID de la conversación/mentor.
@riverpod
class ChatMessages extends _$ChatMessages {
  Timer? _typingTimer;
  String? _conversationId;

  /// 🏗️ **Inicialización**
  ///
  /// 1. Obtiene/Crea la conversación usando el mentorId (recipientId).
  /// 2. Se une a la sala del socket.
  /// 3. Carga historial vía REST.
  /// 4. Escucha nuevos mensajes entrantes.
  @override
  Future<List<MessageEntity>> build(String mentorId) async {
    // 1. Get or Create Conversation to get the real ID
    final conversationResult = await ref.read(chatRepositoryProvider).createConversation(mentorId);
    
    return conversationResult.fold(
      (failure) => throw Exception(failure.message),
      (conversation) async {
        _conversationId = conversation.id;

        // 2. Listen for new messages
        ref.listen(
          chatRepositoryProvider.select((repo) => repo.onNewMessage),
          (previous, next) {
            next.listen((message) {
              if (message.conversationId == _conversationId) {
                // Add new message to state
                state.whenData((messages) {
                  state = AsyncData([...messages, message]);
                });
              }
            });
          },
        );

        // 3. Join conversation
        ref.read(chatWebSocketDataSourceProvider).joinConversation(_conversationId!);

        // Cleanup on dispose
        ref.onDispose(() {
          _typingTimer?.cancel();
          if (_conversationId != null) {
            ref.read(chatWebSocketDataSourceProvider).leaveConversation(_conversationId!);
          }
        });

        // 4. Load initial messages
        return await _loadMessages();
      },
    );
  }

  /// 📥 **Cargar Historial**
  Future<List<MessageEntity>> _loadMessages() async {
    if (_conversationId == null) return [];

    final result = await ref.read(chatRepositoryProvider).getMessages(
          conversationId: _conversationId!,
          offset: 0,
          limit: 50,
        );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (messages) => messages.reversed.toList(), // Reverse for chat order
    );
  }

  /// 📤 **Enviar Mensaje**
  ///
  /// Aplica actualización optimista (agrega mensaje localmente)
  /// y luego envía al servidor.
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    
    if (_conversationId == null) {
      print('ChatController: ⚠️ Cannot send message, _conversationId is null. Chat might not be initialized.');
      return;
    }

    // Stop typing indicator
    stopTyping();

    // Optimistic update
    final optimisticMessage = MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: _conversationId!,
      senderId: 'current_user',
      senderName: 'You',
      content: content,
      timestamp: DateTime.now(),
      isSending: true,
    );

    state.whenData((messages) {
      state = AsyncData([...messages, optimisticMessage]);
    });

    // Send via repository
    final result = await ref.read(chatRepositoryProvider).sendMessage(
          conversationId: _conversationId!,
          content: content,
        );

    result.fold(
      (failure) {
        // Remove optimistic message on error
        state.whenData((messages) {
          state = AsyncData(
            messages.where((m) => m.id != optimisticMessage.id).toList(),
          );
        });
      },
      (_) {
        // Message will be updated via WebSocket event
      },
    );
  }

  /// ⌨️ **Empezar a Escribir**
  void startTyping() {
    if (_conversationId == null) return;
    ref.read(chatRepositoryProvider).startTyping(_conversationId!);

    // Auto-stop after 3 seconds
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 3), () {
      stopTyping();
    });
  }

  /// 🛑 **Dejar de Escribir**
  void stopTyping() {
    if (_conversationId == null) return;
    _typingTimer?.cancel();
    ref.read(chatRepositoryProvider).stopTyping(_conversationId!);
  }

  /// 🔄 **Refrescar Chat**
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadMessages());
  }


}

/// ⌨️ **Indicador de Typing Global**
///
/// Mantiene un mapa de usuarios que están escribiendo.
@riverpod
class TypingIndicator extends _$TypingIndicator {
  @override
  Map<String, bool> build() {
    // Listen for typing events
    ref.listen(
      chatRepositoryProvider.select((repo) => repo.onUserTyping),
      (previous, next) {
        next.listen((typingMap) {
          state = {...state, ...typingMap};
        });
      },
    );

    return {};
  }

  /// 🔍 **Verificar si Usuario Escribe**
  bool isTyping(String userId) {
    return state[userId] ?? false;
  }
}
