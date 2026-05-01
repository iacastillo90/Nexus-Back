import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_datasource.dart';
import '../datasources/chat_websocket_datasource.dart';

/// Implementation of ChatRepository
class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource chatDataSource;
  final ChatWebSocketDataSource webSocketDataSource;

  ChatRepositoryImpl({
    required this.chatDataSource,
    required this.webSocketDataSource,
  });

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final conversations = await chatDataSource.getConversations();
      return Right(conversations.map((c) => c.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> createConversation(String recipientId) async {
    try {
      final conversation = await chatDataSource.createConversation(recipientId);
      return Right(conversation.toEntity());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required String conversationId,
    required int offset,
    required int limit,
  }) async {
    try {
      final messages = await chatDataSource.getMessages(
        conversationId: conversationId,
        offset: offset,
        limit: limit,
      );
      return Right(messages.map((m) => m.toEntity()).toList());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage({
    required String conversationId,
    required String content,
    String type = 'text',
  }) async {
    try {
      // Send via WebSocket
      print('ChatRepositoryImpl: Sending message to $conversationId: $content');
      webSocketDataSource.sendMessage(
        conversationId: conversationId,
        content: content,
        type: type,
      );

      // Create optimistic message
      final optimisticMessage = MessageEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: conversationId,
        senderId: 'current_user', // TODO: Get from auth
        senderName: 'You',
        content: content,
        type: type,
        timestamp: DateTime.now(),
        isSending: true,
        isSent: false,
      );

      return Right(optimisticMessage);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> markAsRead(String conversationId) async {
    try {
      webSocketDataSource.markAsRead(conversationId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(String messageId) async {
    try {
      await chatDataSource.deleteMessage(messageId);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  void startTyping(String conversationId) {
    webSocketDataSource.startTyping(conversationId);
  }

  @override
  void stopTyping(String conversationId) {
    webSocketDataSource.stopTyping(conversationId);
  }

  @override
  Stream<MessageEntity> get onNewMessage {
    return webSocketDataSource.onNewMessage.map((model) => model.toEntity());
  }

  @override
  Stream<Map<String, bool>> get onUserTyping {
    return webSocketDataSource.onUserTyping;
  }

  @override
  Stream<Map<String, bool>> get onUserStatus {
    return webSocketDataSource.onUserStatus;
  }
}
