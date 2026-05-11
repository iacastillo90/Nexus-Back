// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  /// ID único del post.
  String get id => throw _privateConstructorUsedError;

  /// ID del autor.
  String get userId => throw _privateConstructorUsedError;

  /// Nombre de usuario del autor.
  String? get username => throw _privateConstructorUsedError;

  /// Avatar del autor.
  String? get userAvatar => throw _privateConstructorUsedError;

  /// Contenido textual.
  String get content => throw _privateConstructorUsedError;

  /// URLs de archivos adjuntos.
  List<String>? get mediaUrls => throw _privateConstructorUsedError;

  /// Tipo de media ('image', 'video').
  String? get mediaType => throw _privateConstructorUsedError;

  /// Contador de likes.
  int get likesCount => throw _privateConstructorUsedError;

  /// Contador de comentarios.
  int get commentsCount => throw _privateConstructorUsedError;

  /// Contador de compartidos.
  int get sharesCount => throw _privateConstructorUsedError;

  /// Si el usuario actual dio like.
  bool get isLiked => throw _privateConstructorUsedError;

  /// Si el usuario actual guardó el post.
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// Hash de verificación de contenido (Content DNA).
  String? get contentDNA => throw _privateConstructorUsedError;

  /// Capa de realidad (Tech, Art, etc.).
  String? get realityLayer => throw _privateConstructorUsedError;

  /// Metadatos flexibles.
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de actualización.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? username,
      String? userAvatar,
      String content,
      List<String>? mediaUrls,
      String? mediaType,
      int likesCount,
      int commentsCount,
      int sharesCount,
      bool isLiked,
      bool isBookmarked,
      String? contentDNA,
      String? realityLayer,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = freezed,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? mediaUrls = freezed,
    Object? mediaType = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? sharesCount = null,
    Object? isLiked = null,
    Object? isBookmarked = null,
    Object? contentDNA = freezed,
    Object? realityLayer = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrls: freezed == mediaUrls
          ? _value.mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      sharesCount: null == sharesCount
          ? _value.sharesCount
          : sharesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      contentDNA: freezed == contentDNA
          ? _value.contentDNA
          : contentDNA // ignore: cast_nullable_to_non_nullable
              as String?,
      realityLayer: freezed == realityLayer
          ? _value.realityLayer
          : realityLayer // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? username,
      String? userAvatar,
      String content,
      List<String>? mediaUrls,
      String? mediaType,
      int likesCount,
      int commentsCount,
      int sharesCount,
      bool isLiked,
      bool isBookmarked,
      String? contentDNA,
      String? realityLayer,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? username = freezed,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? mediaUrls = freezed,
    Object? mediaType = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? sharesCount = null,
    Object? isLiked = null,
    Object? isBookmarked = null,
    Object? contentDNA = freezed,
    Object? realityLayer = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$PostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUrls: freezed == mediaUrls
          ? _value._mediaUrls
          : mediaUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      mediaType: freezed == mediaType
          ? _value.mediaType
          : mediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      sharesCount: null == sharesCount
          ? _value.sharesCount
          : sharesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isBookmarked: null == isBookmarked
          ? _value.isBookmarked
          : isBookmarked // ignore: cast_nullable_to_non_nullable
              as bool,
      contentDNA: freezed == contentDNA
          ? _value.contentDNA
          : contentDNA // ignore: cast_nullable_to_non_nullable
              as String?,
      realityLayer: freezed == realityLayer
          ? _value.realityLayer
          : realityLayer // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl extends _PostModel {
  const _$PostModelImpl(
      {required this.id,
      required this.userId,
      this.username,
      this.userAvatar,
      required this.content,
      final List<String>? mediaUrls,
      this.mediaType,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.sharesCount = 0,
      this.isLiked = false,
      this.isBookmarked = false,
      this.contentDNA,
      this.realityLayer,
      final Map<String, dynamic>? metadata,
      required this.createdAt,
      required this.updatedAt})
      : _mediaUrls = mediaUrls,
        _metadata = metadata,
        super._();

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  /// ID único del post.
  @override
  final String id;

  /// ID del autor.
  @override
  final String userId;

  /// Nombre de usuario del autor.
  @override
  final String? username;

  /// Avatar del autor.
  @override
  final String? userAvatar;

  /// Contenido textual.
  @override
  final String content;

  /// URLs de archivos adjuntos.
  final List<String>? _mediaUrls;

  /// URLs de archivos adjuntos.
  @override
  List<String>? get mediaUrls {
    final value = _mediaUrls;
    if (value == null) return null;
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Tipo de media ('image', 'video').
  @override
  final String? mediaType;

  /// Contador de likes.
  @override
  @JsonKey()
  final int likesCount;

  /// Contador de comentarios.
  @override
  @JsonKey()
  final int commentsCount;

  /// Contador de compartidos.
  @override
  @JsonKey()
  final int sharesCount;

  /// Si el usuario actual dio like.
  @override
  @JsonKey()
  final bool isLiked;

  /// Si el usuario actual guardó el post.
  @override
  @JsonKey()
  final bool isBookmarked;

  /// Hash de verificación de contenido (Content DNA).
  @override
  final String? contentDNA;

  /// Capa de realidad (Tech, Art, etc.).
  @override
  final String? realityLayer;

  /// Metadatos flexibles.
  final Map<String, dynamic>? _metadata;

  /// Metadatos flexibles.
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Fecha de actualización.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PostModel(id: $id, userId: $userId, username: $username, userAvatar: $userAvatar, content: $content, mediaUrls: $mediaUrls, mediaType: $mediaType, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, contentDNA: $contentDNA, realityLayer: $realityLayer, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality()
                .equals(other._mediaUrls, _mediaUrls) &&
            (identical(other.mediaType, mediaType) ||
                other.mediaType == mediaType) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.sharesCount, sharesCount) ||
                other.sharesCount == sharesCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.contentDNA, contentDNA) ||
                other.contentDNA == contentDNA) &&
            (identical(other.realityLayer, realityLayer) ||
                other.realityLayer == realityLayer) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      username,
      userAvatar,
      content,
      const DeepCollectionEquality().hash(_mediaUrls),
      mediaType,
      likesCount,
      commentsCount,
      sharesCount,
      isLiked,
      isBookmarked,
      contentDNA,
      realityLayer,
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel extends PostModel {
  const factory _PostModel(
      {required final String id,
      required final String userId,
      final String? username,
      final String? userAvatar,
      required final String content,
      final List<String>? mediaUrls,
      final String? mediaType,
      final int likesCount,
      final int commentsCount,
      final int sharesCount,
      final bool isLiked,
      final bool isBookmarked,
      final String? contentDNA,
      final String? realityLayer,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PostModelImpl;
  const _PostModel._() : super._();

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override

  /// ID único del post.
  String get id;
  @override

  /// ID del autor.
  String get userId;
  @override

  /// Nombre de usuario del autor.
  String? get username;
  @override

  /// Avatar del autor.
  String? get userAvatar;
  @override

  /// Contenido textual.
  String get content;
  @override

  /// URLs de archivos adjuntos.
  List<String>? get mediaUrls;
  @override

  /// Tipo de media ('image', 'video').
  String? get mediaType;
  @override

  /// Contador de likes.
  int get likesCount;
  @override

  /// Contador de comentarios.
  int get commentsCount;
  @override

  /// Contador de compartidos.
  int get sharesCount;
  @override

  /// Si el usuario actual dio like.
  bool get isLiked;
  @override

  /// Si el usuario actual guardó el post.
  bool get isBookmarked;
  @override

  /// Hash de verificación de contenido (Content DNA).
  String? get contentDNA;
  @override

  /// Capa de realidad (Tech, Art, etc.).
  String? get realityLayer;
  @override

  /// Metadatos flexibles.
  Map<String, dynamic>? get metadata;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Fecha de actualización.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
