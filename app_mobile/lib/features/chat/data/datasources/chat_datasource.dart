import 'package:dio/dio.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

/// Chat data source for REST API
class ChatDataSource {
  final Dio dio;

  ChatDataSource(this.dio);

  /// Get all conversations
  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await dio.get('/conversations');
      final List<dynamic> data = response.data;
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Create or get conversation with a user
  Future<ConversationModel> createConversation(String recipientId) async {
    try {
      final response = await dio.post(
        '/conversations',
        data: {'recipientId': recipientId},
      );
      
      final data = Map<String, dynamic>.from(response.data);
      
      // 🛠️ Patch: Backend might not return participant info on creation
      if (data['participantId'] == null) {
        data['participantId'] = recipientId;
      }
      if (data['participantName'] == null) {
        data['participantName'] = 'User'; // Placeholder
      }
      
      return ConversationModel.fromJson(data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get messages for a conversation
  Future<List<MessageModel>> getMessages({
    required String conversationId,
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/conversations/$conversationId/messages',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );
      
      List<dynamic> data;
      if (response.data is List) {
        data = response.data;
      } else if (response.data is Map) {
        // Handle pagination wrapper or data envelope
        final map = response.data as Map<String, dynamic>;
        if (map.containsKey('data') && map['data'] is List) {
          data = map['data'];
        } else if (map.containsKey('messages') && map['messages'] is List) {
          data = map['messages'];
        } else if (map.containsKey('results') && map['results'] is List) {
          data = map['results'];
        } else {
          // Fallback: try to find any list in the map
          final firstList = map.values.firstWhere(
            (v) => v is List,
            orElse: () => [],
          );
          data = firstList is List ? firstList : [];
        }
      } else {
        data = [];
      }

      return data.map((json) => MessageModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Delete message
  Future<void> deleteMessage(String messageId) async {
    try {
      await dio.delete('/messages/$messageId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 404:
          return Exception('Resource not found');
        case 401:
          return Exception('Unauthorized');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error $statusCode: $message');
      }
    } else {
      return Exception('Network error');
    }
  }
}
