import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:3000/api/v1';
  static String get socketUrl => dotenv.env['SOCKET_URL'] ?? 'http://10.0.2.2:3000';
  
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String feed = '/posts/feed';
  static const String createPost = '/posts';
}
