// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  /// ID único (UUID).
  String get id => throw _privateConstructorUsedError;

  /// Nombre de usuario único.
  String get username => throw _privateConstructorUsedError;

  /// Correo electrónico.
  String get email => throw _privateConstructorUsedError;

  /// Nombre real (opcional).
  String? get firstName => throw _privateConstructorUsedError;

  /// Apellido real (opcional).
  String? get lastName => throw _privateConstructorUsedError;

  /// Si la cuenta está activa.
  bool get isActive => throw _privateConstructorUsedError;

  /// Si el email/identidad está verificada.
  bool get isVerified => throw _privateConstructorUsedError;

  /// Si tiene activado el asistente Echo.
  bool get echoEnabled => throw _privateConstructorUsedError;

  /// Plan de suscripción ('free', 'premium').
  String get echoPlan => throw _privateConstructorUsedError;

  /// Configuración del gemelo digital.
  Map<String, dynamic>? get echoConfig => throw _privateConstructorUsedError;

  /// Fecha de creación.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de última actualización.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? firstName,
      String? lastName,
      bool isActive,
      bool isVerified,
      bool echoEnabled,
      String echoPlan,
      Map<String, dynamic>? echoConfig,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? isActive = null,
    Object? isVerified = null,
    Object? echoEnabled = null,
    Object? echoPlan = null,
    Object? echoConfig = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      echoEnabled: null == echoEnabled
          ? _value.echoEnabled
          : echoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      echoPlan: null == echoPlan
          ? _value.echoPlan
          : echoPlan // ignore: cast_nullable_to_non_nullable
              as String,
      echoConfig: freezed == echoConfig
          ? _value.echoConfig
          : echoConfig // ignore: cast_nullable_to_non_nullable
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
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? firstName,
      String? lastName,
      bool isActive,
      bool isVerified,
      bool echoEnabled,
      String echoPlan,
      Map<String, dynamic>? echoConfig,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? isActive = null,
    Object? isVerified = null,
    Object? echoEnabled = null,
    Object? echoPlan = null,
    Object? echoConfig = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      echoEnabled: null == echoEnabled
          ? _value.echoEnabled
          : echoEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      echoPlan: null == echoPlan
          ? _value.echoPlan
          : echoPlan // ignore: cast_nullable_to_non_nullable
              as String,
      echoConfig: freezed == echoConfig
          ? _value._echoConfig
          : echoConfig // ignore: cast_nullable_to_non_nullable
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
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      this.firstName,
      this.lastName,
      required this.isActive,
      required this.isVerified,
      required this.echoEnabled,
      this.echoPlan = 'free',
      final Map<String, dynamic>? echoConfig,
      required this.createdAt,
      required this.updatedAt})
      : _echoConfig = echoConfig,
        super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  /// ID único (UUID).
  @override
  final String id;

  /// Nombre de usuario único.
  @override
  final String username;

  /// Correo electrónico.
  @override
  final String email;

  /// Nombre real (opcional).
  @override
  final String? firstName;

  /// Apellido real (opcional).
  @override
  final String? lastName;

  /// Si la cuenta está activa.
  @override
  final bool isActive;

  /// Si el email/identidad está verificada.
  @override
  final bool isVerified;

  /// Si tiene activado el asistente Echo.
  @override
  final bool echoEnabled;

  /// Plan de suscripción ('free', 'premium').
  @override
  @JsonKey()
  final String echoPlan;

  /// Configuración del gemelo digital.
  final Map<String, dynamic>? _echoConfig;

  /// Configuración del gemelo digital.
  @override
  Map<String, dynamic>? get echoConfig {
    final value = _echoConfig;
    if (value == null) return null;
    if (_echoConfig is EqualUnmodifiableMapView) return _echoConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Fecha de creación.
  @override
  final DateTime createdAt;

  /// Fecha de última actualización.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, isActive: $isActive, isVerified: $isVerified, echoEnabled: $echoEnabled, echoPlan: $echoPlan, echoConfig: $echoConfig, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.echoEnabled, echoEnabled) ||
                other.echoEnabled == echoEnabled) &&
            (identical(other.echoPlan, echoPlan) ||
                other.echoPlan == echoPlan) &&
            const DeepCollectionEquality()
                .equals(other._echoConfig, _echoConfig) &&
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
      username,
      email,
      firstName,
      lastName,
      isActive,
      isVerified,
      echoEnabled,
      echoPlan,
      const DeepCollectionEquality().hash(_echoConfig),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String id,
      required final String username,
      required final String email,
      final String? firstName,
      final String? lastName,
      required final bool isActive,
      required final bool isVerified,
      required final bool echoEnabled,
      final String echoPlan,
      final Map<String, dynamic>? echoConfig,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override

  /// ID único (UUID).
  String get id;
  @override

  /// Nombre de usuario único.
  String get username;
  @override

  /// Correo electrónico.
  String get email;
  @override

  /// Nombre real (opcional).
  String? get firstName;
  @override

  /// Apellido real (opcional).
  String? get lastName;
  @override

  /// Si la cuenta está activa.
  bool get isActive;
  @override

  /// Si el email/identidad está verificada.
  bool get isVerified;
  @override

  /// Si tiene activado el asistente Echo.
  bool get echoEnabled;
  @override

  /// Plan de suscripción ('free', 'premium').
  String get echoPlan;
  @override

  /// Configuración del gemelo digital.
  Map<String, dynamic>? get echoConfig;
  @override

  /// Fecha de creación.
  DateTime get createdAt;
  @override

  /// Fecha de última actualización.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
