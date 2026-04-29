import 'dart:async';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/socket_service.dart';
import '../models/message_model.dart';

/// WebSocket data source using Socket.IO
class ChatWebSocketDataSource {
  final SocketService _socketService;

  // Stream controllers
  final _newMessageController = StreamController<MessageModel>.broadcast();
  final _userTypingController = StreamController<Map<String, bool>>.broadcast();
  final _userStatusController = StreamController<Map<String, bool>>.broadcast();
  final _messageSentController = StreamController<MessageModel>.broadcast();

  ChatWebSocketDataSource(this._socketService) {
    _setupListeners();
  }

  void _setupListeners() {
    // Listen for new messages
    _socketService.on('new_message', (data) {
      try {
        final message = MessageModel.fromJson(data);
        _newMessageController.add(message);
      } catch (e) {
        LoggerService.e('Error parsing new message: $e');
      }
    });

    // Listen for message sent confirmation
    _socketService.on('message_sent', (data) {
      try {
        final message = MessageModel.fromJson(data);
        _messageSentController.add(message);
      } catch (e) {
        LoggerService.e('Error parsing message sent: $e');
      }
    });

    // Listen for typing indicators
    _socketService.on('user_typing', (data) {
      try {
        final userId = data['userId'] as String;
        final isTyping = data['isTyping'] as bool;
        _userTypingController.add({userId: isTyping});
      } catch (e) {
        LoggerService.e('Error parsing typing indicator: $e');
      }
    });

    // Listen for online status
    _socketService.on('user_online', (data) {
      try {
        final userId = data['userId'] as String;
        _userStatusController.add({userId: true});
      } catch (e) {
        LoggerService.e('Error parsing user online: $e');
      }
    });

    _socketService.on('user_offline', (data) {
      try {
        final userId = data['userId'] as String;
        _userStatusController.add({userId: false});
      } catch (e) {
        LoggerService.e('Error parsing user offline: $e');
      }
    });
  }

  /// Connect to Socket.IO server (delegated to SocketService)
  Future<void> connect() async {
    await _socketService.connect();
  }

  /// Disconnect from Socket.IO server (delegated to SocketService)
  void disconnect() {
    _socketService.disconnect();
  }

  /// Join a conversation room
  void joinConversation(String conversationId) {
    _socketService.emit('join_conversation', {'conversationId': conversationId});
  }

  /// Leave a conversation room
  void leaveConversation(String conversationId) {
    _socketService.emit('leave_conversation', {'conversationId': conversationId});
  }

  /// Send message
  void sendMessage({
    required String conversationId,
    required String content,
    String type = 'text',
  }) {
    LoggerService.i('ChatWebSocketDataSource: Emitting send_message for conversation $conversationId');
    _socketService.emit('send_message', {
      'conversationId': conversationId,
      'content': content,
      'type': type,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  /// Start typing indicator
  void startTyping(String conversationId) {
    _socketService.emit('typing_start', {'conversationId': conversationId});
  }

  /// Stop typing indicator
  void stopTyping(String conversationId) {
    _socketService.emit('typing_stop', {'conversationId': conversationId});
  }

  /// Mark conversation as read
  void markAsRead(String conversationId) {
    _socketService.emit('mark_read', {'conversationId': conversationId});
  }

  /// Stream of new messages
  Stream<MessageModel> get onNewMessage => _newMessageController.stream;

  /// Stream of message sent confirmations
  Stream<MessageModel> get onMessageSent => _messageSentController.stream;

  /// Stream of typing indicators
  Stream<Map<String, bool>> get onUserTyping => _userTypingController.stream;

  /// Stream of user status
  Stream<Map<String, bool>> get onUserStatus => _userStatusController.stream;

  /// Check if connected
  bool get isConnected => _socketService.isConnected;

  /// Dispose streams
  void dispose() {
    _newMessageController.close();
    _userTypingController.close();
    _userStatusController.close();
    _messageSentController.close();
    // Do not disconnect SocketService here as it might be shared
  }
}
