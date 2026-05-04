import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexus_mobile/features/content/domain/entities/media_entity.dart';

/// Media upload data source (Cloudinary)
class MediaUploadDataSource {
  final Dio dio;

  MediaUploadDataSource(this.dio);

  /// Upload media to Cloudinary
  Future<MediaEntity> uploadMedia({
    required String filePath,
    required String type,
    Function(double)? onProgress,
  }) async {
    try {
      final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
      final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'];

      if (cloudName == null || uploadPreset == null) {
        throw Exception('Cloudinary credentials not configured');
      }

      final file = File(filePath);
      final fileName = file.path.split('/').last;

      // Determine resource type
      String resourceType = 'image';
      if (type == 'video') {
        resourceType = 'video';
      } else if (type == 'audio') {
        resourceType = 'raw';
      }

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
        'upload_preset': uploadPreset,
        'folder': 'nexus/$type',
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload',
        data: formData,
        onSendProgress: (sent, total) {
          if (onProgress != null) {
            final progress = sent / total;
            onProgress(progress);
          }
        },
      );

      final data = response.data;

      return MediaEntity(
        url: data['secure_url'],
        type: type,
        thumbnailUrl: type == 'video' ? data['thumbnail_url'] : null,
        width: data['width'],
        height: data['height'],
        duration: data['duration']?.toInt(),
        size: data['bytes'],
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to upload media: $e');
    }
  }

  /// Delete media from Cloudinary
  Future<void> deleteMedia(String publicId) async {
    try {
      final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
      final apiKey = dotenv.env['CLOUDINARY_API_KEY'];
      final apiSecret = dotenv.env['CLOUDINARY_API_SECRET'];

      if (cloudName == null || apiKey == null || apiSecret == null) {
        throw Exception('Cloudinary credentials not configured');
      }

      // TODO: Implement Cloudinary delete with signature
      // This requires generating a signature with timestamp and api_secret
      // For now, we'll skip deletion (media will remain in Cloudinary)
    } catch (e) {
      throw Exception('Failed to delete media: $e');
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['error']?['message'] ?? 'Upload failed';

      switch (statusCode) {
        case 400:
          return Exception('Invalid file: $message');
        case 401:
          return Exception('Unauthorized: Check Cloudinary credentials');
        case 413:
          return Exception('File too large');
        default:
          return Exception('Upload error: $message');
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return Exception('Upload timeout');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Upload failed');
    }
  }
}
