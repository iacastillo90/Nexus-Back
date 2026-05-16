// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotificationEntity {
  /// ID único de la notificación.
  String get id => throw _privateConstructorUsedError;

  /// ID del usuario destinatario.
  String get userId => throw _privateConstructorUsedError;

  /// Tipo de evento (like, comment, follow...).
  NotificationType get type => throw _privateConstructorUsedError;

  /// Título corto (ej: "Nuevo seguidor").
  String get title => throw _privateConstructorUsedError;

  /// Mensaje descriptivo (ej: "@usuario te ha seguido").
  String get message => throw _privateConstructorUsedError;

  /// ID del usuario que generó la acción (Actor).
  String? get actorId => throw _privateConstructorUsedError;

  /// Nombre del actor (caché).
  String? get actorName => throw _privateConstructorUsedError;

  /// Avatar del actor (caché).
  String? get actorAvatar => throw _privateConstructorUsedError;

  /// ID del objeto afectado (Post ID, Comment ID).
  String? get targetId => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Indica si ya fue vista por el usuario.
  bool get isRead => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificationEntityCopyWith<NotificationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationEntityCopyWith<$Res> {
  factory $NotificationEntityCopyWith(
          NotificationEntity value, $Res Function(NotificationEntity) then) =
      _$NotificationEntityCopyWithImpl<$Res, NotificationEntity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String message,
      String? actorId,
      String? actorName,
      String? actorAvatar,
      String? targetId,
      DateTime createdAt,
      bool isRead});
}

/// @nodoc
class _$NotificationEntityCopyWithImpl<$Res, $Val extends NotificationEntity>
    implements $NotificationEntityCopyWith<$Res> {
  _$NotificationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? actorId = freezed,
    Object? actorName = freezed,
    Object? actorAvatar = freezed,
    Object? targetId = freezed,
    Object? createdAt = null,
    Object? isRead = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      actorId: freezed == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String?,
      actorName: freezed == actorName
          ? _value.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      actorAvatar: freezed == actorAvatar
          ? _value.actorAvatar
          : actorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationEntityImplCopyWith<$Res>
    implements $NotificationEntityCopyWith<$Res> {
  factory _$$NotificationEntityImplCopyWith(_$NotificationEntityImpl value,
          $Res Function(_$NotificationEntityImpl) then) =
      __$$NotificationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String message,
      String? actorId,
      String? actorName,
      String? actorAvatar,
      String? targetId,
      DateTime createdAt,
      bool isRead});
}

/// @nodoc
class __$$NotificationEntityImplCopyWithImpl<$Res>
    extends _$NotificationEntityCopyWithImpl<$Res, _$NotificationEntityImpl>
    implements _$$NotificationEntityImplCopyWith<$Res> {
  __$$NotificationEntityImplCopyWithImpl(_$NotificationEntityImpl _value,
      $Res Function(_$NotificationEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? actorId = freezed,
    Object? actorName = freezed,
    Object? actorAvatar = freezed,
    Object? targetId = freezed,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(_$NotificationEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      actorId: freezed == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String?,
      actorName: freezed == actorName
          ? _value.actorName
          : actorName // ignore: cast_nullable_to_non_nullable
              as String?,
      actorAvatar: freezed == actorAvatar
          ? _value.actorAvatar
          : actorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      targetId: freezed == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NotificationEntityImpl extends _NotificationEntity {
  const _$NotificationEntityImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.title,
      required this.message,
      this.actorId,
      this.actorName,
      this.actorAvatar,
      this.targetId,
      required this.createdAt,
      this.isRead = false})
      : super._();

  /// ID único de la notificación.
  @override
  final String id;

  /// ID del usuario destinatario.
  @override
  final String userId;

  /// Tipo de evento (like, comment, follow...).
  @override
  final NotificationType type;

  /// Título corto (ej: "Nuevo seguidor").
  @override
  final String title;

  /// Mensaje descriptivo (ej: "@usuario te ha seguido").
  @override
  final String message;

  /// ID del usuario que generó la acción (Actor).
  @override
  final String? actorId;

  /// Nombre del actor (caché).
  @override
  final String? actorName;

  /// Avatar del actor (caché).
  @override
  final String? actorAvatar;

  /// ID del objeto afectado (Post ID, Comment ID).
  @override
  final String? targetId;

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Indica si ya fue vista por el usuario.
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'NotificationEntity(id: $id, userId: $userId, type: $type, title: $title, message: $message, actorId: $actorId, actorName: $actorName, actorAvatar: $actorAvatar, targetId: $targetId, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.actorAvatar, actorAvatar) ||
                other.actorAvatar == actorAvatar) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, type, title, message,
      actorId, actorName, actorAvatar, targetId, createdAt, isRead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationEntityImplCopyWith<_$NotificationEntityImpl> get copyWith =>
      __$$NotificationEntityImplCopyWithImpl<_$NotificationEntityImpl>(
          this, _$identity);
}

abstract class _NotificationEntity extends NotificationEntity {
  const factory _NotificationEntity(
      {required final String id,
      required final String userId,
      required final NotificationType type,
      required final String title,
      required final String message,
      final String? actorId,
      final String? actorName,
      final String? actorAvatar,
      final String? targetId,
      required final DateTime createdAt,
      final bool isRead}) = _$NotificationEntityImpl;
  const _NotificationEntity._() : super._();

  @override

  /// ID único de la notificación.
  String get id;
  @override

  /// ID del usuario destinatario.
  String get userId;
  @override

  /// Tipo de evento (like, comment, follow...).
  NotificationType get type;
  @override

  /// Título corto (ej: "Nuevo seguidor").
  String get title;
  @override

  /// Mensaje descriptivo (ej: "@usuario te ha seguido").
  String get message;
  @override

  /// ID del usuario que generó la acción (Actor).
  String? get actorId;
  @override

  /// Nombre del actor (caché).
  String? get actorName;
  @override

  /// Avatar del actor (caché).
  String? get actorAvatar;
  @override

  /// ID del objeto afectado (Post ID, Comment ID).
  String? get targetId;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Indica si ya fue vista por el usuario.
  bool get isRead;
  @override
  @JsonKey(ignore: true)
  _$$NotificationEntityImplCopyWith<_$NotificationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
