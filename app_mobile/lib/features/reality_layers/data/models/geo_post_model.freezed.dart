// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geo_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GeoPostModel _$GeoPostModelFromJson(Map<String, dynamic> json) {
  return _GeoPostModel.fromJson(json);
}

/// @nodoc
mixin _$GeoPostModel {
  String get id => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String? get authorAvatar => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  List<String>? get mediaUrls => throw _privateConstructorUsedError;
  String get realityLayer => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get locationName => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeoPostModelCopyWith<GeoPostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoPostModelCopyWith<$Res> {
  factory $GeoPostModelCopyWith(
          GeoPostModel value, $Res Function(GeoPostModel) then) =
      _$GeoPostModelCopyWithImpl<$Res, GeoPostModel>;
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String? authorAvatar,
      String content,
      List<String>? mediaUrls,
      String realityLayer,
      double latitude,
      double longitude,
      String? locationName,
      DateTime createdAt,
      int likeCount,
      int commentCount,
      bool isLiked,
      double? distance});
}

/// @nodoc
class _$GeoPostModelCopyWithImpl<$Res, $Val extends GeoPostModel>
    implements $GeoPostModelCopyWith<$Res> {
  _$GeoPostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? content = null,
    Object? mediaUrls = freezed,
    Object? realityLayer = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? locationName = freezed,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isLiked = null,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: freezed == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrls: freezed == mediaUrls
          ? _value.mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      realityLayer: null == realityLayer
          ? _value.realityLayer
          : realityLayer // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeoPostModelImplCopyWith<$Res>
    implements $GeoPostModelCopyWith<$Res> {
  factory _$$GeoPostModelImplCopyWith(
          _$GeoPostModelImpl value, $Res Function(_$GeoPostModelImpl) then) =
      __$$GeoPostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String? authorAvatar,
      String content,
      List<String>? mediaUrls,
      String realityLayer,
      double latitude,
      double longitude,
      String? locationName,
      DateTime createdAt,
      int likeCount,
      int commentCount,
      bool isLiked,
      double? distance});
}

/// @nodoc
class __$$GeoPostModelImplCopyWithImpl<$Res>
    extends _$GeoPostModelCopyWithImpl<$Res, _$GeoPostModelImpl>
    implements _$$GeoPostModelImplCopyWith<$Res> {
  __$$GeoPostModelImplCopyWithImpl(
      _$GeoPostModelImpl _value, $Res Function(_$GeoPostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? authorAvatar = freezed,
    Object? content = null,
    Object? mediaUrls = freezed,
    Object? realityLayer = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? locationName = freezed,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isLiked = null,
    Object? distance = freezed,
  }) {
    return _then(_$GeoPostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatar: freezed == authorAvatar
          ? _value.authorAvatar
          : authorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrls: freezed == mediaUrls
          ? _value._mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      realityLayer: null == realityLayer
          ? _value.realityLayer
          : realityLayer // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      locationName: freezed == locationName
          ? _value.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GeoPostModelImpl extends _GeoPostModel {
  const _$GeoPostModelImpl(
      {required this.id,
      required this.authorId,
      required this.authorName,
      this.authorAvatar,
      required this.content,
      final List<String>? mediaUrls,
      required this.realityLayer,
      required this.latitude,
      required this.longitude,
      this.locationName,
      required this.createdAt,
      this.likeCount = 0,
      this.commentCount = 0,
      this.isLiked = false,
      this.distance})
      : _mediaUrls = mediaUrls,
        super._();

  factory _$GeoPostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GeoPostModelImplFromJson(json);

  @override
  final String id;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String? authorAvatar;
  @override
  final String content;
  final List<String>? _mediaUrls;
  @override
  List<String>? get mediaUrls {
    final value = _mediaUrls;
    if (value == null) return null;
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String realityLayer;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? locationName;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  final double? distance;

  @override
  String toString() {
    return 'GeoPostModel(id: $id, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, content: $content, mediaUrls: $mediaUrls, realityLayer: $realityLayer, latitude: $latitude, longitude: $longitude, locationName: $locationName, createdAt: $createdAt, likeCount: $likeCount, commentCount: $commentCount, isLiked: $isLiked, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoPostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorAvatar, authorAvatar) ||
                other.authorAvatar == authorAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._mediaUrls, _mediaUrls) &&
            (identical(other.realityLayer, realityLayer) ||
                other.realityLayer == realityLayer) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      authorName,
      authorAvatar,
      content,
      const DeepCollectionEquality().hash(_mediaUrls),
      realityLayer,
      latitude,
      longitude,
      locationName,
      createdAt,
      likeCount,
      commentCount,
      isLiked,
      distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeoPostModelImplCopyWith<_$GeoPostModelImpl> get copyWith =>
      __$$GeoPostModelImplCopyWithImpl<_$GeoPostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GeoPostModelImplToJson(
      this,
    );
  }
}

abstract class _GeoPostModel extends GeoPostModel {
  const factory _GeoPostModel(
      {required final String id,
      required final String authorId,
      required final String authorName,
      final String? authorAvatar,
      required final String content,
      final List<String>? mediaUrls,
      required final String realityLayer,
      required final double latitude,
      required final double longitude,
      final String? locationName,
      required final DateTime createdAt,
      final int likeCount,
      final int commentCount,
      final bool isLiked,
      final double? distance}) = _$GeoPostModelImpl;
  const _GeoPostModel._() : super._();

  factory _GeoPostModel.fromJson(Map<String, dynamic> json) =
      _$GeoPostModelImpl.fromJson;

  @override
  String get id;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String? get authorAvatar;
  @override
  String get content;
  @override
  List<String>? get mediaUrls;
  @override
  String get realityLayer;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get locationName;
  @override
  DateTime get createdAt;
  @override
  int get likeCount;
  @override
  int get commentCount;
  @override
  bool get isLiked;
  @override
  double? get distance;
  @override
  @JsonKey(ignore: true)
  _$$GeoPostModelImplCopyWith<_$GeoPostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
