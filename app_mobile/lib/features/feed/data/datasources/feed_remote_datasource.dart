import 'package:dio/dio.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';

/// ☁️ **Fuente de Datos Remota del Feed**
///
/// Gestiona la comunicación HTTP con el backend para Posts y Comentarios.
///
/// **Responsabilidades:**
/// - Obtener Feed paginado.
/// - CRUD de Posts (Crear, Leer, Borrar).
/// - Interacciones (Like, Bookmark).
/// - Gestión de Comentarios.
///
/// **Referencias:**
/// - Backend: `src/routes/post.routes.js`
class FeedRemoteDataSource {
  final Dio dio;

  FeedRemoteDataSource(this.dio);

  /// 📰 **Obtener Feed**
  ///
  /// Recupera una lista paginada de posts.
  ///
  /// **Parámetros:**
  /// - [offset]: Desplazamiento (paginación).
  /// - [limit]: Cantidad máxima de items.
  Future<List<PostModel>> getFeed({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/posts/feed',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );

      // Handle different response structures
      dynamic responseData = response.data;
      
      // If response.data is a Map, try to extract the posts array
      if (responseData is Map<String, dynamic>) {
        responseData = responseData['data'] ?? responseData['posts'] ?? responseData;
      }
      
      // Ensure we have a List
      if (responseData is! List) {
        throw Exception('Invalid feed response format: expected List, got ${responseData.runtimeType}');
      }
      
      final List<dynamic> postsJson = responseData;
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// ❤️ **Dar Like a Post**
  Future<void> likePost(String postId) async {
    try {
      await dio.post('/posts/$postId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 💔 **Quitar Like a Post**
  Future<void> unlikePost(String postId) async {
    try {
      await dio.delete('/posts/$postId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🔖 **Guardar Post (Bookmark)**
  Future<void> bookmarkPost(String postId) async {
    try {
      await dio.post('/posts/$postId/bookmark');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🗑️ **Quitar Bookmark**
  Future<void> unbookmarkPost(String postId) async {
    try {
      await dio.delete('/posts/$postId/bookmark');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🔍 **Obtener Post por ID**
  Future<PostModel> getPostById(String postId) async {
    try {
      final response = await dio.get('/posts/$postId');
      return PostModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🗑️ **Borrar Post**
  Future<void> deletePost(String postId) async {
    try {
      await dio.delete('/posts/$postId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 💬 **Obtener Comentarios**
  Future<List<CommentModel>> getComments({
    required String postId,
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await dio.get(
        '/posts/$postId/comments',
        queryParameters: {
          'offset': offset,
          'limit': limit,
        },
      );

      final List<dynamic> commentsJson =
          response.data['comments'] ?? response.data;
      return commentsJson.map((json) => CommentModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// ➕ **Agregar Comentario**
  Future<CommentModel> addComment({
    required String postId,
    required String content,
  }) async {
    try {
      final response = await dio.post(
        '/posts/$postId/comments',
        data: {'content': content},
      );

      return CommentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// ❤️ **Dar Like a Comentario**
  Future<void> likeComment(String commentId) async {
    try {
      await dio.post('/comments/$commentId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 💔 **Quitar Like a Comentario**
  Future<void> unlikeComment(String commentId) async {
    try {
      await dio.delete('/comments/$commentId/like');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🗑️ **Borrar Comentario**
  Future<void> deleteComment(String commentId) async {
    try {
      await dio.delete('/comments/$commentId');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// 🚨 **Manejo de Errores Dio**
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'Unknown error';

      switch (statusCode) {
        case 400:
          return Exception('Bad request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 404:
          return Exception('Not found: $message');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error $statusCode: $message');
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unknown error occurred');
    }
  }
}
