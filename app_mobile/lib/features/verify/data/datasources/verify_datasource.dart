import 'package:dio/dio.dart';
import '../models/verification_result_model.dart';
import '../../domain/entities/verification_result_entity.dart';

/// Verify data source
class VerifyDataSource {
  final Dio dio;

  VerifyDataSource(this.dio);

  /// Verify by QR code
  Future<VerificationResultModel> verifyByQR(String qrData) async {
    try {
      final response = await dio.post(
        '/verify/qr',
        data: {'qrData': qrData},
      );

      return VerificationResultModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Verify by content ID
  Future<VerificationResultModel> verifyById(String contentId) async {
    try {
      final response = await dio.get('/verify/$contentId');
      return VerificationResultModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get content DNA
  Future<String> getContentDNA(String contentId) async {
    try {
      final response = await dio.get('/verify/$contentId/dna');
      return response.data['dna'] as String;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors
  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data?['message'] ?? 'Unknown error';
      return Exception('Error $statusCode: $message');
    } else {
      return Exception('Connection error');
    }
  }
}
