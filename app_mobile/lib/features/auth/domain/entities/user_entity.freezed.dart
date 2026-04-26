// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserEntity {
  /// ID único del usuario (UUID v4 generado por el Backend).
  String get id => throw _privateConstructorUsedError;

  /// Nombre de usuario único (@handle).
  String get username => throw _privateConstructorUsedError;

  /// Correo electrónico verificado.
  String get email => throw _privateConstructorUsedError;

  /// Nombre real (opcional).
  String? get firstName => throw _privateConstructorUsedError;

  /// Apellido real (opcional).
  String? get lastName => throw _privateConstructorUsedError;

  /// Indica si la cuenta está activa (no baneada/suspendida).
  bool get isActive => throw _privateConstructorUsedError;

  /// Indica si el usuario ha verificado su identidad (Blue Check).
  bool get isVerified => throw _privateConstructorUsedError;

  /// Indica si el asistente IA (Echo) está habilitado para este usuario.
  bool get echoEnabled => throw _privateConstructorUsedError;

  /// Plan de suscripción de Echo.
  /// Valores: 'free' (básico), 'premium' (avanzado), 'creator' (ilimitado).
  String get echoPlan => throw _privateConstructorUsedError;

  /// Configuración del gemelo digital (Auto-Reply, Autonomy).
  Map<String, dynamic>? get echoConfig => throw _privateConstructorUsedError;

  /// Fecha de creación de la cuenta.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de última actualización del perfil.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserEntityCopyWith<UserEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntityCopyWith<$Res> {
  factory $UserEntityCopyWith(
          UserEntity value, $Res Function(UserEntity) then) =
      _$UserEntityCopyWithImpl<$Res, UserEntity>;
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
class _$UserEntityCopyWithImpl<$Res, $Val extends UserEntity>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._value, this._then);

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
abstract class _$$UserEntityImplCopyWith<$Res>
    implements $UserEntityCopyWith<$Res> {
  factory _$$UserEntityImplCopyWith(
          _$UserEntityImpl value, $Res Function(_$UserEntityImpl) then) =
      __$$UserEntityImplCopyWithImpl<$Res>;
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
class __$$UserEntityImplCopyWithImpl<$Res>
    extends _$UserEntityCopyWithImpl<$Res, _$UserEntityImpl>
    implements _$$UserEntityImplCopyWith<$Res> {
  __$$UserEntityImplCopyWithImpl(
      _$UserEntityImpl _value, $Res Function(_$UserEntityImpl) _then)
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
    return _then(_$UserEntityImpl(
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

class _$UserEntityImpl extends _UserEntity {
  const _$UserEntityImpl(
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

  /// ID único del usuario (UUID v4 generado por el Backend).
  @override
  final String id;

  /// Nombre de usuario único (@handle).
  @override
  final String username;

  /// Correo electrónico verificado.
  @override
  final String email;

  /// Nombre real (opcional).
  @override
  final String? firstName;

  /// Apellido real (opcional).
  @override
  final String? lastName;

  /// Indica si la cuenta está activa (no baneada/suspendida).
  @override
  final bool isActive;

  /// Indica si el usuario ha verificado su identidad (Blue Check).
  @override
  final bool isVerified;

  /// Indica si el asistente IA (Echo) está habilitado para este usuario.
  @override
  final bool echoEnabled;

  /// Plan de suscripción de Echo.
  /// Valores: 'free' (básico), 'premium' (avanzado), 'creator' (ilimitado).
  @override
  @JsonKey()
  final String echoPlan;

  /// Configuración del gemelo digital (Auto-Reply, Autonomy).
  final Map<String, dynamic>? _echoConfig;

  /// Configuración del gemelo digital (Auto-Reply, Autonomy).
  @override
  Map<String, dynamic>? get echoConfig {
    final value = _echoConfig;
    if (value == null) return null;
    if (_echoConfig is EqualUnmodifiableMapView) return _echoConfig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Fecha de creación de la cuenta.
  @override
  final DateTime createdAt;

  /// Fecha de última actualización del perfil.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, isActive: $isActive, isVerified: $isVerified, echoEnabled: $echoEnabled, echoPlan: $echoPlan, echoConfig: $echoConfig, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEntityImpl &&
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
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      __$$UserEntityImplCopyWithImpl<_$UserEntityImpl>(this, _$identity);
}

abstract class _UserEntity extends UserEntity {
  const factory _UserEntity(
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
      required final DateTime updatedAt}) = _$UserEntityImpl;
  const _UserEntity._() : super._();

  @override

  /// ID único del usuario (UUID v4 generado por el Backend).
  String get id;
  @override

  /// Nombre de usuario único (@handle).
  String get username;
  @override

  /// Correo electrónico verificado.
  String get email;
  @override

  /// Nombre real (opcional).
  String? get firstName;
  @override

  /// Apellido real (opcional).
  String? get lastName;
  @override

  /// Indica si la cuenta está activa (no baneada/suspendida).
  bool get isActive;
  @override

  /// Indica si el usuario ha verificado su identidad (Blue Check).
  bool get isVerified;
  @override

  /// Indica si el asistente IA (Echo) está habilitado para este usuario.
  bool get echoEnabled;
  @override

  /// Plan de suscripción de Echo.
  /// Valores: 'free' (básico), 'premium' (avanzado), 'creator' (ilimitado).
  String get echoPlan;
  @override

  /// Configuración del gemelo digital (Auto-Reply, Autonomy).
  Map<String, dynamic>? get echoConfig;
  @override

  /// Fecha de creación de la cuenta.
  DateTime get createdAt;
  @override

  /// Fecha de última actualización del perfil.
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserEntityImplCopyWith<_$UserEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
