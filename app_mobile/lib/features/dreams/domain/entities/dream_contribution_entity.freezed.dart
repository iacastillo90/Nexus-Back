// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_contribution_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DreamContributionEntity {
  /// ID único de la contribución.
  String get id => throw _privateConstructorUsedError;

  /// ID del sueño al que pertenece.
  String get dreamId => throw _privateConstructorUsedError;

  /// ID del autor.
  String get userId => throw _privateConstructorUsedError;

  /// Nombre del autor (caché).
  String get userName => throw _privateConstructorUsedError;

  /// Avatar del autor (caché).
  String? get userAvatar => throw _privateConstructorUsedError;

  /// Texto narrativo.
  String get content => throw _privateConstructorUsedError;

  /// Posición en la secuencia (1, 2, 3...).
  int get order => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Contador de likes locales.
  int get likeCount => throw _privateConstructorUsedError;

  /// Si el usuario actual le dio like.
  bool get isLiked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DreamContributionEntityCopyWith<DreamContributionEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DreamContributionEntityCopyWith<$Res> {
  factory $DreamContributionEntityCopyWith(DreamContributionEntity value,
          $Res Function(DreamContributionEntity) then) =
      _$DreamContributionEntityCopyWithImpl<$Res, DreamContributionEntity>;
  @useResult
  $Res call(
      {String id,
      String dreamId,
      String userId,
      String userName,
      String? userAvatar,
      String content,
      int order,
      DateTime createdAt,
      int likeCount,
      bool isLiked});
}

/// @nodoc
class _$DreamContributionEntityCopyWithImpl<$Res,
        $Val extends DreamContributionEntity>
    implements $DreamContributionEntityCopyWith<$Res> {
  _$DreamContributionEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dreamId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? order = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? isLiked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dreamId: null == dreamId
          ? _value.dreamId
          : dreamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DreamContributionEntityImplCopyWith<$Res>
    implements $DreamContributionEntityCopyWith<$Res> {
  factory _$$DreamContributionEntityImplCopyWith(
          _$DreamContributionEntityImpl value,
          $Res Function(_$DreamContributionEntityImpl) then) =
      __$$DreamContributionEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String dreamId,
      String userId,
      String userName,
      String? userAvatar,
      String content,
      int order,
      DateTime createdAt,
      int likeCount,
      bool isLiked});
}

/// @nodoc
class __$$DreamContributionEntityImplCopyWithImpl<$Res>
    extends _$DreamContributionEntityCopyWithImpl<$Res,
        _$DreamContributionEntityImpl>
    implements _$$DreamContributionEntityImplCopyWith<$Res> {
  __$$DreamContributionEntityImplCopyWithImpl(
      _$DreamContributionEntityImpl _value,
      $Res Function(_$DreamContributionEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? dreamId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? content = null,
    Object? order = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? isLiked = null,
  }) {
    return _then(_$DreamContributionEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      dreamId: null == dreamId
          ? _value.dreamId
          : dreamId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: freezed == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DreamContributionEntityImpl extends _DreamContributionEntity {
  const _$DreamContributionEntityImpl(
      {required this.id,
      required this.dreamId,
      required this.userId,
      required this.userName,
      this.userAvatar,
      required this.content,
      required this.order,
      required this.createdAt,
      this.likeCount = 0,
      this.isLiked = false})
      : super._();

  /// ID único de la contribución.
  @override
  final String id;

  /// ID del sueño al que pertenece.
  @override
  final String dreamId;

  /// ID del autor.
  @override
  final String userId;

  /// Nombre del autor (caché).
  @override
  final String userName;

  /// Avatar del autor (caché).
  @override
  final String? userAvatar;

  /// Texto narrativo.
  @override
  final String content;

  /// Posición en la secuencia (1, 2, 3...).
  @override
  final int order;

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Contador de likes locales.
  @override
  @JsonKey()
  final int likeCount;

  /// Si el usuario actual le dio like.
  @override
  @JsonKey()
  final bool isLiked;

  @override
  String toString() {
    return 'DreamContributionEntity(id: $id, dreamId: $dreamId, userId: $userId, userName: $userName, userAvatar: $userAvatar, content: $content, order: $order, createdAt: $createdAt, likeCount: $likeCount, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DreamContributionEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.dreamId, dreamId) || other.dreamId == dreamId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, dreamId, userId, userName,
      userAvatar, content, order, createdAt, likeCount, isLiked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DreamContributionEntityImplCopyWith<_$DreamContributionEntityImpl>
      get copyWith => __$$DreamContributionEntityImplCopyWithImpl<
          _$DreamContributionEntityImpl>(this, _$identity);
}

abstract class _DreamContributionEntity extends DreamContributionEntity {
  const factory _DreamContributionEntity(
      {required final String id,
      required final String dreamId,
      required final String userId,
      required final String userName,
      final String? userAvatar,
      required final String content,
      required final int order,
      required final DateTime createdAt,
      final int likeCount,
      final bool isLiked}) = _$DreamContributionEntityImpl;
  const _DreamContributionEntity._() : super._();

  @override

  /// ID único de la contribución.
  String get id;
  @override

  /// ID del sueño al que pertenece.
  String get dreamId;
  @override

  /// ID del autor.
  String get userId;
  @override

  /// Nombre del autor (caché).
  String get userName;
  @override

  /// Avatar del autor (caché).
  String? get userAvatar;
  @override

  /// Texto narrativo.
  String get content;
  @override

  /// Posición en la secuencia (1, 2, 3...).
  int get order;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Contador de likes locales.
  int get likeCount;
  @override

  /// Si el usuario actual le dio like.
  bool get isLiked;
  @override
  @JsonKey(ignore: true)
  _$$DreamContributionEntityImplCopyWith<_$DreamContributionEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
