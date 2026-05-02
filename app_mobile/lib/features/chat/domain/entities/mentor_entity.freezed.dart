// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mentor_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MentorEntity {
  /// ID único del mentor (slug: 'echo', 'dr_luma', etc.).
  String get id => throw _privateConstructorUsedError;

  /// Nombre visible del mentor.
  String get name => throw _privateConstructorUsedError;

  /// Área de especialidad (ej: "Tecnología", "Ciencia", "Seguridad").
  String get specialty => throw _privateConstructorUsedError;

  /// URL o path del avatar.
  String get avatar => throw _privateConstructorUsedError;

  /// Descripción breve del rol del mentor.
  String get description => throw _privateConstructorUsedError;

  /// Prompt de sistema que define su tono y estilo de respuesta.
  String get personality => throw _privateConstructorUsedError;

  /// Lista de temas en los que es experto.
  List<String> get expertise => throw _privateConstructorUsedError;

  /// Siempre true para IAs (siempre disponibles).
  bool get isOnline => throw _privateConstructorUsedError;

  /// Mensajes no leídos de este mentor.
  int get unreadCount => throw _privateConstructorUsedError;

  /// Último mensaje intercambiado.
  String? get lastMessage => throw _privateConstructorUsedError;

  /// Fecha del último mensaje.
  DateTime? get lastMessageTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MentorEntityCopyWith<MentorEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MentorEntityCopyWith<$Res> {
  factory $MentorEntityCopyWith(
          MentorEntity value, $Res Function(MentorEntity) then) =
      _$MentorEntityCopyWithImpl<$Res, MentorEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String specialty,
      String avatar,
      String description,
      String personality,
      List<String> expertise,
      bool isOnline,
      int unreadCount,
      String? lastMessage,
      DateTime? lastMessageTime});
}

/// @nodoc
class _$MentorEntityCopyWithImpl<$Res, $Val extends MentorEntity>
    implements $MentorEntityCopyWith<$Res> {
  _$MentorEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specialty = null,
    Object? avatar = null,
    Object? description = null,
    Object? personality = null,
    Object? expertise = null,
    Object? isOnline = null,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specialty: null == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: null == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MentorEntityImplCopyWith<$Res>
    implements $MentorEntityCopyWith<$Res> {
  factory _$$MentorEntityImplCopyWith(
          _$MentorEntityImpl value, $Res Function(_$MentorEntityImpl) then) =
      __$$MentorEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String specialty,
      String avatar,
      String description,
      String personality,
      List<String> expertise,
      bool isOnline,
      int unreadCount,
      String? lastMessage,
      DateTime? lastMessageTime});
}

/// @nodoc
class __$$MentorEntityImplCopyWithImpl<$Res>
    extends _$MentorEntityCopyWithImpl<$Res, _$MentorEntityImpl>
    implements _$$MentorEntityImplCopyWith<$Res> {
  __$$MentorEntityImplCopyWithImpl(
      _$MentorEntityImpl _value, $Res Function(_$MentorEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? specialty = null,
    Object? avatar = null,
    Object? description = null,
    Object? personality = null,
    Object? expertise = null,
    Object? isOnline = null,
    Object? unreadCount = null,
    Object? lastMessage = freezed,
    Object? lastMessageTime = freezed,
  }) {
    return _then(_$MentorEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      specialty: null == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      personality: null == personality
          ? _value.personality
          : personality // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: null == expertise
          ? _value._expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageTime: freezed == lastMessageTime
          ? _value.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$MentorEntityImpl extends _MentorEntity {
  const _$MentorEntityImpl(
      {required this.id,
      required this.name,
      required this.specialty,
      required this.avatar,
      required this.description,
      required this.personality,
      final List<String> expertise = const [],
      this.isOnline = true,
      this.unreadCount = 0,
      this.lastMessage,
      this.lastMessageTime})
      : _expertise = expertise,
        super._();

  /// ID único del mentor (slug: 'echo', 'dr_luma', etc.).
  @override
  final String id;

  /// Nombre visible del mentor.
  @override
  final String name;

  /// Área de especialidad (ej: "Tecnología", "Ciencia", "Seguridad").
  @override
  final String specialty;

  /// URL o path del avatar.
  @override
  final String avatar;

  /// Descripción breve del rol del mentor.
  @override
  final String description;

  /// Prompt de sistema que define su tono y estilo de respuesta.
  @override
  final String personality;

  /// Lista de temas en los que es experto.
  final List<String> _expertise;

  /// Lista de temas en los que es experto.
  @override
  @JsonKey()
  List<String> get expertise {
    if (_expertise is EqualUnmodifiableListView) return _expertise;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expertise);
  }

  /// Siempre true para IAs (siempre disponibles).
  @override
  @JsonKey()
  final bool isOnline;

  /// Mensajes no leídos de este mentor.
  @override
  @JsonKey()
  final int unreadCount;

  /// Último mensaje intercambiado.
  @override
  final String? lastMessage;

  /// Fecha del último mensaje.
  @override
  final DateTime? lastMessageTime;

  @override
  String toString() {
    return 'MentorEntity(id: $id, name: $name, specialty: $specialty, avatar: $avatar, description: $description, personality: $personality, expertise: $expertise, isOnline: $isOnline, unreadCount: $unreadCount, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MentorEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.personality, personality) ||
                other.personality == personality) &&
            const DeepCollectionEquality()
                .equals(other._expertise, _expertise) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      specialty,
      avatar,
      description,
      personality,
      const DeepCollectionEquality().hash(_expertise),
      isOnline,
      unreadCount,
      lastMessage,
      lastMessageTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MentorEntityImplCopyWith<_$MentorEntityImpl> get copyWith =>
      __$$MentorEntityImplCopyWithImpl<_$MentorEntityImpl>(this, _$identity);
}

abstract class _MentorEntity extends MentorEntity {
  const factory _MentorEntity(
      {required final String id,
      required final String name,
      required final String specialty,
      required final String avatar,
      required final String description,
      required final String personality,
      final List<String> expertise,
      final bool isOnline,
      final int unreadCount,
      final String? lastMessage,
      final DateTime? lastMessageTime}) = _$MentorEntityImpl;
  const _MentorEntity._() : super._();

  @override

  /// ID único del mentor (slug: 'echo', 'dr_luma', etc.).
  String get id;
  @override

  /// Nombre visible del mentor.
  String get name;
  @override

  /// Área de especialidad (ej: "Tecnología", "Ciencia", "Seguridad").
  String get specialty;
  @override

  /// URL o path del avatar.
  String get avatar;
  @override

  /// Descripción breve del rol del mentor.
  String get description;
  @override

  /// Prompt de sistema que define su tono y estilo de respuesta.
  String get personality;
  @override

  /// Lista de temas en los que es experto.
  List<String> get expertise;
  @override

  /// Siempre true para IAs (siempre disponibles).
  bool get isOnline;
  @override

  /// Mensajes no leídos de este mentor.
  int get unreadCount;
  @override

  /// Último mensaje intercambiado.
  String? get lastMessage;
  @override

  /// Fecha del último mensaje.
  DateTime? get lastMessageTime;
  @override
  @JsonKey(ignore: true)
  _$$MentorEntityImplCopyWith<_$MentorEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
