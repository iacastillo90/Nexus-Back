// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentEntity {
  /// ID único del comentario (UUID v4).
  String get id => throw _privateConstructorUsedError;

  /// ID del post al que pertenece.
  String get postId => throw _privateConstructorUsedError;

  /// ID del autor del comentario.
  String get userId => throw _privateConstructorUsedError;

  /// Nombre de usuario del autor (caché).
  String get username => throw _privateConstructorUsedError;

  /// Avatar del autor (caché).
  String? get userAvatar => throw _privateConstructorUsedError;

  /// Texto del comentario.
  String get content => throw _privateConstructorUsedError;

  /// Contador de likes en este comentario.
  int get likesCount => throw _privateConstructorUsedError;

  /// Indica si el usuario actual dio like a este comentario.
  bool get isLiked => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de última edición.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentEntityCopyWith<CommentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentEntityCopyWith<$Res> {
  factory $CommentEntityCopyWith(
          CommentEntity value, $Res Function(CommentEntity) then) =
      _$CommentEntityCopyWithImpl<$Res, CommentEntity>;
  @useResult
  $Res call(
      {String id,
      String postId,
      String userId,
      String username,
      String? userAvatar,
      String content,
      int likesCount,
      bool isLiked,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$CommentEntityCopyWithImpl<$Res, $Val extends CommentEntity>
    implements $CommentEntityCopyWith<$Res> {
  _$CommentEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? username = null,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? likesCount = null,
    Object? isLiked = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$CommentEntityImplCopyWith<$Res>
    implements $CommentEntityCopyWith<$Res> {
  factory _$$CommentEntityImplCopyWith(
          _$CommentEntityImpl value, $Res Function(_$CommentEntityImpl) then) =
      __$$CommentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String userId,
      String username,
      String? userAvatar,
      String content,
      int likesCount,
      bool isLiked,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$CommentEntityImplCopyWithImpl<$Res>
    extends _$CommentEntityCopyWithImpl<$Res, _$CommentEntityImpl>
    implements _$$CommentEntityImplCopyWith<$Res> {
  __$$CommentEntityImplCopyWithImpl(
      _$CommentEntityImpl _value, $Res Function(_$CommentEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? userId = null,
    Object? username = null,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? likesCount = null,
    Object? isLiked = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$CommentEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$CommentEntityImpl extends _CommentEntity {
  const _$CommentEntityImpl(
      {required this.id,
      required this.postId,
      required this.userId,
      required this.username,
      this.userAvatar,
      required this.content,
      required this.likesCount,
      required this.isLiked,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  /// ID único del comentario (UUID v4).
  @override
  final String id;

  /// ID del post al que pertenece.
  @override
  final String postId;

  /// ID del autor del comentario.
  @override
  final String userId;

  /// Nombre de usuario del autor (caché).
  @override
  final String username;

  /// Avatar del autor (caché).
  @override
  final String? userAvatar;

  /// Texto del comentario.
  @override
  final String content;

  /// Contador de likes en este comentario.
  @override
  final int likesCount;

  /// Indica si el usuario actual dio like a este comentario.
  @override
  final bool isLiked;

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Fecha de última edición.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'CommentEntity(id: $id, postId: $postId, userId: $userId, username: $username, userAvatar: $userAvatar, content: $content, likesCount: $likesCount, isLiked: $isLiked, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, postId, userId, username,
      userAvatar, content, likesCount, isLiked, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      __$$CommentEntityImplCopyWithImpl<_$CommentEntityImpl>(this, _$identity);
}

abstract class _CommentEntity extends CommentEntity {
  const factory _CommentEntity(
      {required final String id,
      required final String postId,
      required final String userId,
      required final String username,
      final String? userAvatar,
      required final String content,
      required final int likesCount,
      required final bool isLiked,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$CommentEntityImpl;
  const _CommentEntity._() : super._();

  @override

  /// ID único del comentario (UUID v4).
  String get id;
  @override

  /// ID del post al que pertenece.
  String get postId;
  @override

  /// ID del autor del comentario.
  String get userId;
  @override

  /// Nombre de usuario del autor (caché).
  String get username;
  @override

  /// Avatar del autor (caché).
  String? get userAvatar;
  @override

  /// Texto del comentario.
  String get content;
  @override

  /// Contador de likes en este comentario.
  int get likesCount;
  @override

  /// Indica si el usuario actual dio like a este comentario.
  bool get isLiked;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Fecha de última edición.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
