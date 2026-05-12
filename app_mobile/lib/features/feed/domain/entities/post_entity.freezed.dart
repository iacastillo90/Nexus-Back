// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostEntity {
  /// ID único de la publicación (UUID v4).
  String get id => throw _privateConstructorUsedError;

  /// ID del autor de la publicación.
  String get userId => throw _privateConstructorUsedError;

  /// Nombre de usuario del autor (caché para evitar joins costosos).
  String? get username => throw _privateConstructorUsedError;

  /// URL del avatar del autor (caché).
  String? get userAvatar => throw _privateConstructorUsedError;

  /// Contenido textual de la publicación.
  String get content => throw _privateConstructorUsedError;

  /// Lista de URLs de archivos multimedia adjuntos (imágenes, videos).
  List<String>? get mediaUrls => throw _privateConstructorUsedError;

  /// Tipo de multimedia principal.
  /// Valores: 'image', 'video', 'audio', o null si es solo texto.
  String? get mediaType => throw _privateConstructorUsedError;

  /// Contador total de "Me gusta".
  int get likesCount => throw _privateConstructorUsedError;

  /// Contador total de comentarios.
  int get commentsCount => throw _privateConstructorUsedError;

  /// Contador total de veces compartido.
  int get sharesCount => throw _privateConstructorUsedError;

  /// Indica si el usuario actual ha dado like a este post.
  bool get isLiked => throw _privateConstructorUsedError;

  /// Indica si el usuario actual ha guardado este post.
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// 🧬 **Content DNA**
  /// Hash criptográfico único que garantiza la autenticidad y origen del contenido.
  /// Se usa para prevenir deepfakes y verificar la autoría.
  String? get contentDNA => throw _privateConstructorUsedError;

  /// 🌐 **Capa de Realidad**
  /// Define en qué plano existe este contenido.
  /// - 'physical': Fotos/Videos del mundo real.
  /// - 'digital': Arte digital, capturas de pantalla, código.
  /// - 'hybrid': Realidad Aumentada (AR) o contenido mixto.
  String? get realityLayer => throw _privateConstructorUsedError;

  /// Metadatos adicionales flexibles (ej: ubicación, etiquetas IA).
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Fecha de publicación original.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de última edición.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostEntityCopyWith<PostEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEntityCopyWith<$Res> {
  factory $PostEntityCopyWith(
          PostEntity value, $Res Function(PostEntity) then) =
      _$PostEntityCopyWithImpl<$Res, PostEntity>;
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
class _$PostEntityCopyWithImpl<$Res, $Val extends PostEntity>
    implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$PostEntityImplCopyWith<$Res>
    implements $PostEntityCopyWith<$Res> {
  factory _$$PostEntityImplCopyWith(
          _$PostEntityImpl value, $Res Function(_$PostEntityImpl) then) =
      __$$PostEntityImplCopyWithImpl<$Res>;
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
class __$$PostEntityImplCopyWithImpl<$Res>
    extends _$PostEntityCopyWithImpl<$Res, _$PostEntityImpl>
    implements _$$PostEntityImplCopyWith<$Res> {
  __$$PostEntityImplCopyWithImpl(
      _$PostEntityImpl _value, $Res Function(_$PostEntityImpl) _then)
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
    return _then(_$PostEntityImpl(
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

class _$PostEntityImpl extends _PostEntity {
  const _$PostEntityImpl(
      {required this.id,
      required this.userId,
      this.username,
      this.userAvatar,
      required this.content,
      final List<String>? mediaUrls,
      this.mediaType,
      required this.likesCount,
      required this.commentsCount,
      required this.sharesCount,
      required this.isLiked,
      required this.isBookmarked,
      this.contentDNA,
      this.realityLayer,
      final Map<String, dynamic>? metadata,
      required this.createdAt,
      required this.updatedAt})
      : _mediaUrls = mediaUrls,
        _metadata = metadata,
        super._();

  /// ID único de la publicación (UUID v4).
  @override
  final String id;

  /// ID del autor de la publicación.
  @override
  final String userId;

  /// Nombre de usuario del autor (caché para evitar joins costosos).
  @override
  final String? username;

  /// URL del avatar del autor (caché).
  @override
  final String? userAvatar;

  /// Contenido textual de la publicación.
  @override
  final String content;

  /// Lista de URLs de archivos multimedia adjuntos (imágenes, videos).
  final List<String>? _mediaUrls;

  /// Lista de URLs de archivos multimedia adjuntos (imágenes, videos).
  @override
  List<String>? get mediaUrls {
    final value = _mediaUrls;
    if (value == null) return null;
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Tipo de multimedia principal.
  /// Valores: 'image', 'video', 'audio', o null si es solo texto.
  @override
  final String? mediaType;

  /// Contador total de "Me gusta".
  @override
  final int likesCount;

  /// Contador total de comentarios.
  @override
  final int commentsCount;

  /// Contador total de veces compartido.
  @override
  final int sharesCount;

  /// Indica si el usuario actual ha dado like a este post.
  @override
  final bool isLiked;

  /// Indica si el usuario actual ha guardado este post.
  @override
  final bool isBookmarked;

  /// 🧬 **Content DNA**
  /// Hash criptográfico único que garantiza la autenticidad y origen del contenido.
  /// Se usa para prevenir deepfakes y verificar la autoría.
  @override
  final String? contentDNA;

  /// 🌐 **Capa de Realidad**
  /// Define en qué plano existe este contenido.
  /// - 'physical': Fotos/Videos del mundo real.
  /// - 'digital': Arte digital, capturas de pantalla, código.
  /// - 'hybrid': Realidad Aumentada (AR) o contenido mixto.
  @override
  final String? realityLayer;

  /// Metadatos adicionales flexibles (ej: ubicación, etiquetas IA).
  final Map<String, dynamic>? _metadata;

  /// Metadatos adicionales flexibles (ej: ubicación, etiquetas IA).
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Fecha de publicación original.
  @override
  final DateTime createdAt;

  /// Fecha de última edición.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'PostEntity(id: $id, userId: $userId, username: $username, userAvatar: $userAvatar, content: $content, mediaUrls: $mediaUrls, mediaType: $mediaType, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, contentDNA: $contentDNA, realityLayer: $realityLayer, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostEntityImpl &&
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
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      __$$PostEntityImplCopyWithImpl<_$PostEntityImpl>(this, _$identity);
}

abstract class _PostEntity extends PostEntity {
  const factory _PostEntity(
      {required final String id,
      required final String userId,
      final String? username,
      final String? userAvatar,
      required final String content,
      final List<String>? mediaUrls,
      final String? mediaType,
      required final int likesCount,
      required final int commentsCount,
      required final int sharesCount,
      required final bool isLiked,
      required final bool isBookmarked,
      final String? contentDNA,
      final String? realityLayer,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$PostEntityImpl;
  const _PostEntity._() : super._();

  @override

  /// ID único de la publicación (UUID v4).
  String get id;
  @override

  /// ID del autor de la publicación.
  String get userId;
  @override

  /// Nombre de usuario del autor (caché para evitar joins costosos).
  String? get username;
  @override

  /// URL del avatar del autor (caché).
  String? get userAvatar;
  @override

  /// Contenido textual de la publicación.
  String get content;
  @override

  /// Lista de URLs de archivos multimedia adjuntos (imágenes, videos).
  List<String>? get mediaUrls;
  @override

  /// Tipo de multimedia principal.
  /// Valores: 'image', 'video', 'audio', o null si es solo texto.
  String? get mediaType;
  @override

  /// Contador total de "Me gusta".
  int get likesCount;
  @override

  /// Contador total de comentarios.
  int get commentsCount;
  @override

  /// Contador total de veces compartido.
  int get sharesCount;
  @override

  /// Indica si el usuario actual ha dado like a este post.
  bool get isLiked;
  @override

  /// Indica si el usuario actual ha guardado este post.
  bool get isBookmarked;
  @override

  /// 🧬 **Content DNA**
  /// Hash criptográfico único que garantiza la autenticidad y origen del contenido.
  /// Se usa para prevenir deepfakes y verificar la autoría.
  String? get contentDNA;
  @override

  /// 🌐 **Capa de Realidad**
  /// Define en qué plano existe este contenido.
  /// - 'physical': Fotos/Videos del mundo real.
  /// - 'digital': Arte digital, capturas de pantalla, código.
  /// - 'hybrid': Realidad Aumentada (AR) o contenido mixto.
  String? get realityLayer;
  @override

  /// Metadatos adicionales flexibles (ej: ubicación, etiquetas IA).
  Map<String, dynamic>? get metadata;
  @override

  /// Fecha de publicación original.
  DateTime get createdAt;
  @override

  /// Fecha de última edición.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
