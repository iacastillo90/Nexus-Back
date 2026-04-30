import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/conversation_entity.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

/// Conversation model for JSON serialization
@freezed
class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required String id,
    required String participantId,
    required String participantName,
    String? participantAvatar,
    String? lastMessage,
    DateTime? lastMessageTime,
    @Default(0) int unreadCount,
    @Default(false) bool isOnline,
    @Default(false) bool isTyping,
    DateTime? lastSeen,
  }) = _ConversationModel;

  const ConversationModel._();

  /// From JSON
  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  /// To Entity
  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      participantId: participantId,
      participantName: participantName,
      participantAvatar: participantAvatar,
      lastMessage: lastMessage,
      lastMessageTime: lastMessageTime,
      unreadCount: unreadCount,
      isOnline: isOnline,
      isTyping: isTyping,
      lastSeen: lastSeen,
    );
  }
}
