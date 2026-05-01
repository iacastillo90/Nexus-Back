// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConversationEntity {
  /// ID único de la conversación (UUID v4).
  String get id => throw _privateConstructorUsedError;

  /// ID del otro participante (usuario con quien se habla).
  String get participantId => throw _privateConstructorUsedError;

  /// Nombre del participante (caché).
  String get participantName => throw _privateConstructorUsedError;

  /// Avatar del participante (caché).
  String? get participantAvatar => throw _privateConstructorUsedError;

  /// Contenido del último mensaje (para vista previa).
  String? get lastMessage => throw _privateConstructorUsedError;

  /// Fecha del último mensaje (para ordenamiento).
  DateTime? get lastMessageTime => throw _privateConstructorUsedError;

  /// Cantidad de mensajes no leídos en esta conversación.
  int get unreadCount => throw _privateConstructorUsedError;

  /// Indica si el participante está conectado actualmente.
  bool get isOnline => throw _privateConstructorUsedError;

  /// Indica si el participante está escribiendo...
  bool get isTyping => throw _privateConstructorUsedError;

  /// Fecha de última conexión del participante.
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConversationEntityCopyWith<ConversationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationEntityCopyWith<$Res> {
  factory $ConversationEntityCopyWith(
          ConversationEntity value, $Res Function(ConversationEntity) then) =
      _$ConversationEntityCopyWithImpl<$Res, ConversationEntity>;
  @useResult
  $Res call(
      {String id,
      String participantId,
      String participantName,
      String? participantAvatar,
      String? lastMessage,
      DateTime? lastMessageTime,
      int unreadCount,
      bool isOnline,
      bool isTyping,
      DateTime? lastSeen});
}

/// @nodoc
class _$ConversationEntityCopyWithImpl<$Res, $Val extends ConversationEntity>
    implements $ConversationEntityCopyWith<$Res> {
  _$ConversationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? participantId = null,
    Object? participantName = null,
    Object? participantAvatar = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? unreadCount = null,
    Object? isOnline = null,
    Object? isTyping = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _value.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      participantAvatar: freezed == participantAvatar
          ? _value.participantAvatar
          : participantAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationEntityImplCopyWith<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  factory _$$ConversationEntityImplCopyWith(_$ConversationEntityImpl value,
          $Res Function(_$ConversationEntityImpl) then) =
      __$$ConversationEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String participantId,
      String participantName,
      String? participantAvatar,
      String? lastMessage,
      DateTime? lastMessageTime,
      int unreadCount,
      bool isOnline,
      bool isTyping,
      DateTime? lastSeen});
}

/// @nodoc
class __$$ConversationEntityImplCopyWithImpl<$Res>
    extends _$ConversationEntityCopyWithImpl<$Res, _$ConversationEntityImpl>
    implements _$$ConversationEntityImplCopyWith<$Res> {
  __$$ConversationEntityImplCopyWithImpl(_$ConversationEntityImpl _value,
      $Res Function(_$ConversationEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? participantId = null,
    Object? participantName = null,
    Object? participantAvatar = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
    Object? unreadCount = null,
    Object? isOnline = null,
    Object? isTyping = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_$ConversationEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      participantId: null == participantId
          ? _value.participantId
          : participantId // ignore: cast_nullable_to_non_nullable
              as String,
      participantName: null == participantName
          ? _value.participantName
          : participantName // ignore: cast_nullable_to_non_nullable
              as String,
      participantAvatar: freezed == participantAvatar
          ? _value.participantAvatar
          : participantAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$ConversationEntityImpl extends _ConversationEntity {
  const _$ConversationEntityImpl(
      {required this.id,
      required this.participantId,
      required this.participantName,
      this.participantAvatar,
      this.lastMessage,
      this.lastMessageTime,
      this.unreadCount = 0,
      this.isOnline = false,
      this.isTyping = false,
      this.lastSeen})
      : super._();

  /// ID único de la conversación (UUID v4).
  @override
  final String id;

  /// ID del otro participante (usuario con quien se habla).
  @override
  final String participantId;

  /// Nombre del participante (caché).
  @override
  final String participantName;

  /// Avatar del participante (caché).
  @override
  final String? participantAvatar;

  /// Contenido del último mensaje (para vista previa).
  @override
  final String? lastMessage;

  /// Fecha del último mensaje (para ordenamiento).
  @override
  final DateTime? lastMessageTime;

  /// Cantidad de mensajes no leídos en esta conversación.
  @override
  @JsonKey()
  final int unreadCount;

  /// Indica si el participante está conectado actualmente.
  @override
  @JsonKey()
  final bool isOnline;

  /// Indica si el participante está escribiendo...
  @override
  @JsonKey()
  final bool isTyping;

  /// Fecha de última conexión del participante.
  @override
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'ConversationEntity(id: $id, participantId: $participantId, participantName: $participantName, participantAvatar: $participantAvatar, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, isOnline: $isOnline, isTyping: $isTyping, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.participantId, participantId) ||
                other.participantId == participantId) &&
            (identical(other.participantName, participantName) ||
                other.participantName == participantName) &&
            (identical(other.participantAvatar, participantAvatar) ||
                other.participantAvatar == participantAvatar) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      participantId,
      participantName,
      participantAvatar,
      lastMessage,
      lastMessageTime,
      unreadCount,
      isOnline,
      isTyping,
      lastSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationEntityImplCopyWith<_$ConversationEntityImpl> get copyWith =>
      __$$ConversationEntityImplCopyWithImpl<_$ConversationEntityImpl>(
          this, _$identity);
}

abstract class _ConversationEntity extends ConversationEntity {
  const factory _ConversationEntity(
      {required final String id,
      required final String participantId,
      required final String participantName,
      final String? participantAvatar,
      final String? lastMessage,
      final DateTime? lastMessageTime,
      final int unreadCount,
      final bool isOnline,
      final bool isTyping,
      final DateTime? lastSeen}) = _$ConversationEntityImpl;
  const _ConversationEntity._() : super._();

  @override

  /// ID único de la conversación (UUID v4).
  String get id;
  @override

  /// ID del otro participante (usuario con quien se habla).
  String get participantId;
  @override

  /// Nombre del participante (caché).
  String get participantName;
  @override

  /// Avatar del participante (caché).
  String? get participantAvatar;
  @override

  /// Contenido del último mensaje (para vista previa).
  String? get lastMessage;
  @override

  /// Fecha del último mensaje (para ordenamiento).
  DateTime? get lastMessageTime;
  @override

  /// Cantidad de mensajes no leídos en esta conversación.
  int get unreadCount;
  @override

  /// Indica si el participante está conectado actualmente.
  bool get isOnline;
  @override

  /// Indica si el participante está escribiendo...
  bool get isTyping;
  @override

  /// Fecha de última conexión del participante.
  DateTime? get lastSeen;
  @override
  @JsonKey(ignore: true)
  _$$ConversationEntityImplCopyWith<_$ConversationEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
