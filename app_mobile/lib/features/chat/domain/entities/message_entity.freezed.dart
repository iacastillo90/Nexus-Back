// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessageEntity {
  /// ID único del mensaje (UUID v4).
  String get id => throw _privateConstructorUsedError;

  /// ID de la conversación a la que pertenece.
  String get conversationId => throw _privateConstructorUsedError;

  /// ID del usuario que envió el mensaje.
  String get senderId => throw _privateConstructorUsedError;

  /// Nombre del remitente (caché).
  String get senderName => throw _privateConstructorUsedError;

  /// Avatar del remitente (caché).
  String? get senderAvatar => throw _privateConstructorUsedError;

  /// Contenido del mensaje (payload).
  String get content => throw _privateConstructorUsedError;

  /// Tipo de mensaje.
  /// Valores: 'text', 'image', 'audio'.
  String get type => throw _privateConstructorUsedError;

  /// Marca de tiempo de creación.
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Indica si el destinatario ha leído el mensaje.
  bool get isRead => throw _privateConstructorUsedError;

  /// Indica si el mensaje ha sido confirmado por el servidor.
  /// Si es `false`, el mensaje está pendiente de sincronización (Offline).
  bool get isSent => throw _privateConstructorUsedError;

  /// Indica si el mensaje se está enviando actualmente (UI optimista).
  bool get isSending => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderAvatar,
      String content,
      String type,
      DateTime timestamp,
      bool isRead,
      bool isSent,
      bool isSending});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatar = freezed,
    Object? content = null,
    Object? type = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isSent = null,
    Object? isSending = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatar: freezed == senderAvatar
          ? _value.senderAvatar
          : senderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageEntityImplCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$MessageEntityImplCopyWith(
          _$MessageEntityImpl value, $Res Function(_$MessageEntityImpl) then) =
      __$$MessageEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String senderName,
      String? senderAvatar,
      String content,
      String type,
      DateTime timestamp,
      bool isRead,
      bool isSent,
      bool isSending});
}

/// @nodoc
class __$$MessageEntityImplCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$MessageEntityImpl>
    implements _$$MessageEntityImplCopyWith<$Res> {
  __$$MessageEntityImplCopyWithImpl(
      _$MessageEntityImpl _value, $Res Function(_$MessageEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? senderAvatar = freezed,
    Object? content = null,
    Object? type = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? isSent = null,
    Object? isSending = null,
  }) {
    return _then(_$MessageEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _value.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatar: freezed == senderAvatar
          ? _value.senderAvatar
          : senderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isSent: null == isSent
          ? _value.isSent
          : isSent // ignore: cast_nullable_to_non_nullable
              as bool,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$MessageEntityImpl extends _MessageEntity {
  const _$MessageEntityImpl(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      required this.senderName,
      this.senderAvatar,
      required this.content,
      this.type = 'text',
      required this.timestamp,
      this.isRead = false,
      this.isSent = true,
      this.isSending = false})
      : super._();

  /// ID único del mensaje (UUID v4).
  @override
  final String id;

  /// ID de la conversación a la que pertenece.
  @override
  final String conversationId;

  /// ID del usuario que envió el mensaje.
  @override
  final String senderId;

  /// Nombre del remitente (caché).
  @override
  final String senderName;

  /// Avatar del remitente (caché).
  @override
  final String? senderAvatar;

  /// Contenido del mensaje (payload).
  @override
  final String content;

  /// Tipo de mensaje.
  /// Valores: 'text', 'image', 'audio'.
  @override
  @JsonKey()
  final String type;

  /// Marca de tiempo de creación.
  @override
  final DateTime timestamp;

  /// Indica si el destinatario ha leído el mensaje.
  @override
  @JsonKey()
  final bool isRead;

  /// Indica si el mensaje ha sido confirmado por el servidor.
  /// Si es `false`, el mensaje está pendiente de sincronización (Offline).
  @override
  @JsonKey()
  final bool isSent;

  /// Indica si el mensaje se está enviando actualmente (UI optimista).
  @override
  @JsonKey()
  final bool isSending;

  @override
  String toString() {
    return 'MessageEntity(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, content: $content, type: $type, timestamp: $timestamp, isRead: $isRead, isSent: $isSent, isSending: $isSending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderAvatar, senderAvatar) ||
                other.senderAvatar == senderAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isSent, isSent) || other.isSent == isSent) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      conversationId,
      senderId,
      senderName,
      senderAvatar,
      content,
      type,
      timestamp,
      isRead,
      isSent,
      isSending);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      __$$MessageEntityImplCopyWithImpl<_$MessageEntityImpl>(this, _$identity);
}

abstract class _MessageEntity extends MessageEntity {
  const factory _MessageEntity(
      {required final String id,
      required final String conversationId,
      required final String senderId,
      required final String senderName,
      final String? senderAvatar,
      required final String content,
      final String type,
      required final DateTime timestamp,
      final bool isRead,
      final bool isSent,
      final bool isSending}) = _$MessageEntityImpl;
  const _MessageEntity._() : super._();

  @override

  /// ID único del mensaje (UUID v4).
  String get id;
  @override

  /// ID de la conversación a la que pertenece.
  String get conversationId;
  @override

  /// ID del usuario que envió el mensaje.
  String get senderId;
  @override

  /// Nombre del remitente (caché).
  String get senderName;
  @override

  /// Avatar del remitente (caché).
  String? get senderAvatar;
  @override

  /// Contenido del mensaje (payload).
  String get content;
  @override

  /// Tipo de mensaje.
  /// Valores: 'text', 'image', 'audio'.
  String get type;
  @override

  /// Marca de tiempo de creación.
  DateTime get timestamp;
  @override

  /// Indica si el destinatario ha leído el mensaje.
  bool get isRead;
  @override

  /// Indica si el mensaje ha sido confirmado por el servidor.
  /// Si es `false`, el mensaje está pendiente de sincronización (Offline).
  bool get isSent;
  @override

  /// Indica si el mensaje se está enviando actualmente (UI optimista).
  bool get isSending;
  @override
  @JsonKey(ignore: true)
  _$$MessageEntityImplCopyWith<_$MessageEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
