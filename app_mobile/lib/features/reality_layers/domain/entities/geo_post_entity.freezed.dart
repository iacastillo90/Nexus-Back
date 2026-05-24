// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geo_post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GeoPostEntity {
  /// ID único del post.
  String get id => throw _privateConstructorUsedError;

  /// ID del autor.
  String get authorId => throw _privateConstructorUsedError;

  /// Nombre del autor.
  String get authorName => throw _privateConstructorUsedError;

  /// Avatar del autor.
  String? get authorAvatar => throw _privateConstructorUsedError;

  /// Contenido del mensaje.
  String get content => throw _privateConstructorUsedError;

  /// Multimedia adjunta.
  List<String>? get mediaUrls => throw _privateConstructorUsedError;

  /// Capa de realidad a la que pertenece.
  String get realityLayer => throw _privateConstructorUsedError;

  /// Latitud geográfica.
  double get latitude => throw _privateConstructorUsedError;

  /// Longitud geográfica.
  double get longitude => throw _privateConstructorUsedError;

  /// Nombre legible del lugar (Reverse Geocoding).
  String? get locationName => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Likes.
  int get likeCount => throw _privateConstructorUsedError;

  /// Comentarios.
  int get commentCount => throw _privateConstructorUsedError;

  /// Si el usuario le dio like.
  bool get isLiked => throw _privateConstructorUsedError;

  /// Distancia calculada desde el usuario (en km).
  double? get distance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GeoPostEntityCopyWith<GeoPostEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeoPostEntityCopyWith<$Res> {
  factory $GeoPostEntityCopyWith(
          GeoPostEntity value, $Res Function(GeoPostEntity) then) =
      _$GeoPostEntityCopyWithImpl<$Res, GeoPostEntity>;
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
class _$GeoPostEntityCopyWithImpl<$Res, $Val extends GeoPostEntity>
    implements $GeoPostEntityCopyWith<$Res> {
  _$GeoPostEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$GeoPostEntityImplCopyWith<$Res>
    implements $GeoPostEntityCopyWith<$Res> {
  factory _$$GeoPostEntityImplCopyWith(
          _$GeoPostEntityImpl value, $Res Function(_$GeoPostEntityImpl) then) =
      __$$GeoPostEntityImplCopyWithImpl<$Res>;
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
class __$$GeoPostEntityImplCopyWithImpl<$Res>
    extends _$GeoPostEntityCopyWithImpl<$Res, _$GeoPostEntityImpl>
    implements _$$GeoPostEntityImplCopyWith<$Res> {
  __$$GeoPostEntityImplCopyWithImpl(
      _$GeoPostEntityImpl _value, $Res Function(_$GeoPostEntityImpl) _then)
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
    return _then(_$GeoPostEntityImpl(
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

class _$GeoPostEntityImpl extends _GeoPostEntity {
  const _$GeoPostEntityImpl(
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

  /// ID único del post.
  @override
  final String id;

  /// ID del autor.
  @override
  final String authorId;

  /// Nombre del autor.
  @override
  final String authorName;

  /// Avatar del autor.
  @override
  final String? authorAvatar;

  /// Contenido del mensaje.
  @override
  final String content;

  /// Multimedia adjunta.
  final List<String>? _mediaUrls;

  /// Multimedia adjunta.
  @override
  List<String>? get mediaUrls {
    final value = _mediaUrls;
    if (value == null) return null;
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Capa de realidad a la que pertenece.
  @override
  final String realityLayer;

  /// Latitud geográfica.
  @override
  final double latitude;

  /// Longitud geográfica.
  @override
  final double longitude;

  /// Nombre legible del lugar (Reverse Geocoding).
  @override
  final String? locationName;

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Likes.
  @override
  @JsonKey()
  final int likeCount;

  /// Comentarios.
  @override
  @JsonKey()
  final int commentCount;

  /// Si el usuario le dio like.
  @override
  @JsonKey()
  final bool isLiked;

  /// Distancia calculada desde el usuario (en km).
  @override
  final double? distance;

  @override
  String toString() {
    return 'GeoPostEntity(id: $id, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, content: $content, mediaUrls: $mediaUrls, realityLayer: $realityLayer, latitude: $latitude, longitude: $longitude, locationName: $locationName, createdAt: $createdAt, likeCount: $likeCount, commentCount: $commentCount, isLiked: $isLiked, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeoPostEntityImpl &&
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
  _$$GeoPostEntityImplCopyWith<_$GeoPostEntityImpl> get copyWith =>
      __$$GeoPostEntityImplCopyWithImpl<_$GeoPostEntityImpl>(this, _$identity);
}

abstract class _GeoPostEntity extends GeoPostEntity {
  const factory _GeoPostEntity(
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
      final double? distance}) = _$GeoPostEntityImpl;
  const _GeoPostEntity._() : super._();

  @override

  /// ID único del post.
  String get id;
  @override

  /// ID del autor.
  String get authorId;
  @override

  /// Nombre del autor.
  String get authorName;
  @override

  /// Avatar del autor.
  String? get authorAvatar;
  @override

  /// Contenido del mensaje.
  String get content;
  @override

  /// Multimedia adjunta.
  List<String>? get mediaUrls;
  @override

  /// Capa de realidad a la que pertenece.
  String get realityLayer;
  @override

  /// Latitud geográfica.
  double get latitude;
  @override

  /// Longitud geográfica.
  double get longitude;
  @override

  /// Nombre legible del lugar (Reverse Geocoding).
  String? get locationName;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Likes.
  int get likeCount;
  @override

  /// Comentarios.
  int get commentCount;
  @override

  /// Si el usuario le dio like.
  bool get isLiked;
  @override

  /// Distancia calculada desde el usuario (en km).
  double? get distance;
  @override
  @JsonKey(ignore: true)
  _$$GeoPostEntityImplCopyWith<_$GeoPostEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
