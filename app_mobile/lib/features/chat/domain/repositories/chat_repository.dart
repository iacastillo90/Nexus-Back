import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/message_entity.dart';
import '../entities/conversation_entity.dart';

/// 💬 **Repositorio de Chat (Contrato)**
///
/// Define las operaciones de mensajería en tiempo real.
/// Combina API REST (historial) y WebSockets (eventos en vivo).
///
/// **Responsabilidades:**
/// - Listar conversaciones y mensajes.
/// - Enviar mensajes (Texto, Multimedia).
/// - Gestionar indicadores de estado (Typing, Online).
///
/// **Implementación:**
/// - Ver `lib/features/chat/data/repositories/chat_repository_impl.dart`
abstract class ChatRepository {
  /// 📂 **Obtener Conversaciones**
  ///
  /// Lista los chats activos del usuario.
  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  /// ➕ **Crear/Obtener Conversación**
  ///
  /// Obtiene una conversación existente con un usuario o crea una nueva.
  Future<Either<Failure, ConversationEntity>> createConversation(String recipientId);

  /// 📜 **Obtener Mensajes**
  ///
  /// Recupera el historial de un chat específico.
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required int offset,
    required int limit,
  });

  /// 📤 **Enviar Mensaje**
  ///
  /// Envía un nuevo mensaje a través del socket/API.
  Future<Either<Failure, MessageEntity>> sendMessage({
    required String conversationId,
    required String content,
    String type = 'text',
  });

  /// 👀 **Marcar como Leído**
  Future<Either<Failure, Unit>> markAsRead(String conversationId);

  /// 🗑️ **Borrar Mensaje**
  Future<Either<Failure, Unit>> deleteMessage(String messageId);

  /// ⌨️ **Empezar a Escribir**
  ///
  /// Emite evento de "Typing..." al socket.
  void startTyping(String conversationId);

  /// 🛑 **Dejar de Escribir**
  void stopTyping(String conversationId);

  /// 📨 **Stream de Nuevos Mensajes**
  ///
  /// Escucha eventos `new_message` del socket.
  Stream<MessageEntity> get onNewMessage;

  /// ⌨️ **Stream de Typing**
  ///
  /// Escucha eventos `user_typing` del socket.
  Stream<Map<String, bool>> get onUserTyping;

  /// 🟢 **Stream de Estado Online**
  ///
  /// Escucha eventos de presencia de usuarios.
  Stream<Map<String, bool>> get onUserStatus;
}
