import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/search_result_entity.dart';

part 'search_result_model.freezed.dart';
part 'search_result_model.g.dart';

/// Search result model for JSON serialization
@freezed
class SearchResultModel with _$SearchResultModel {
  const factory SearchResultModel({
    required String id,
    required String type,
    required String title,
    required String subtitle,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) = _SearchResultModel;

  const SearchResultModel._();

  /// From JSON
  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      _$SearchResultModelFromJson(json);

  /// To Entity
  SearchResultEntity toEntity() {
    return SearchResultEntity(
      id: id,
      type: _parseType(type),
      title: title,
      subtitle: subtitle,
      imageUrl: imageUrl,
      metadata: metadata,
    );
  }

  SearchResultType _parseType(String type) {
    switch (type.toLowerCase()) {
      case 'user':
        return SearchResultType.user;
      case 'post':
        return SearchResultType.post;
      case 'tag':
        return SearchResultType.tag;
      default:
        return SearchResultType.post;
    }
  }
}
