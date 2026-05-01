import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/message_entity.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// Message model for JSON serialization
@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String conversationId,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    required String content,
    @Default('text') String type,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(true) bool isSent,
    @Default(false) bool isSending,
  }) = _MessageModel;

  const MessageModel._();

  /// From JSON
  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  /// To Entity
  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      content: content,
      type: type,
      timestamp: timestamp,
      isRead: isRead,
      isSent: isSent,
      isSending: isSending,
    );
  }

  /// From Entity
  factory MessageModel.fromEntity(MessageEntity entity) {
    return MessageModel(
      id: entity.id,
      conversationId: entity.conversationId,
      senderId: entity.senderId,
      senderName: entity.senderName,
      senderAvatar: entity.senderAvatar,
      content: entity.content,
      type: entity.type,
      timestamp: entity.timestamp,
      isRead: entity.isRead,
      isSent: entity.isSent,
      isSending: entity.isSending,
    );
  }
}
