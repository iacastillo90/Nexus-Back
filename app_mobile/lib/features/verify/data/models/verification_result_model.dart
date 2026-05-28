import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/verification_result_entity.dart';

part 'verification_result_model.freezed.dart';
part 'verification_result_model.g.dart';

/// Verification result model for JSON serialization
@freezed
class VerificationResultModel with _$VerificationResultModel {
  const factory VerificationResultModel({
    required String contentId,
    required String contentDNA,
    required String status,
    required double authenticityScore,
    required DateTime verifiedAt,
    String? originalAuthor,
    String? originalSource,
    DateTime? originalDate,
    @Default([]) List<String> modifications,
  }) = _VerificationResultModel;

  const VerificationResultModel._();

  /// From JSON
  factory VerificationResultModel.fromJson(Map<String, dynamic> json) =>
      _$VerificationResultModelFromJson(json);

  /// To Entity
  VerificationResultEntity toEntity() {
    return VerificationResultEntity(
      contentId: contentId,
      contentDNA: contentDNA,
      status: _parseStatus(status),
      authenticityScore: authenticityScore,
      verifiedAt: verifiedAt,
      originalAuthor: originalAuthor,
      originalSource: originalSource,
      originalDate: originalDate,
      modifications: modifications,
    );
  }

  VerificationStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'verified':
        return VerificationStatus.verified;
      case 'suspicious':
        return VerificationStatus.suspicious;
      case 'fake':
        return VerificationStatus.fake;
      default:
        return VerificationStatus.unknown;
    }
  }
}
