// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BadgeEntity {
  /// ID único de la insignia.
  String get id => throw _privateConstructorUsedError;

  /// Nombre visible del logro.
  String get name => throw _privateConstructorUsedError;

  /// Descripción de cómo se obtuvo.
  String get description => throw _privateConstructorUsedError;

  /// URL del icono visual.
  String get iconUrl => throw _privateConstructorUsedError;

  /// Categoría del logro.
  /// Valores: 'karma', 'content', 'community', 'special'.
  String get category => throw _privateConstructorUsedError;

  /// Fecha de obtención.
  DateTime get earnedAt => throw _privateConstructorUsedError;

  /// Nivel de la insignia (1=Bronce, 2=Plata, 3=Oro).
  int? get level => throw _privateConstructorUsedError;

  /// Indica si es una insignia de evento limitado o difícil de conseguir.
  bool? get isRare => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BadgeEntityCopyWith<BadgeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeEntityCopyWith<$Res> {
  factory $BadgeEntityCopyWith(
          BadgeEntity value, $Res Function(BadgeEntity) then) =
      _$BadgeEntityCopyWithImpl<$Res, BadgeEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconUrl,
      String category,
      DateTime earnedAt,
      int? level,
      bool? isRare});
}

/// @nodoc
class _$BadgeEntityCopyWithImpl<$Res, $Val extends BadgeEntity>
    implements $BadgeEntityCopyWith<$Res> {
  _$BadgeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? category = null,
    Object? earnedAt = null,
    Object? level = freezed,
    Object? isRare = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      earnedAt: null == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      isRare: freezed == isRare
          ? _value.isRare
          : isRare // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeEntityImplCopyWith<$Res>
    implements $BadgeEntityCopyWith<$Res> {
  factory _$$BadgeEntityImplCopyWith(
          _$BadgeEntityImpl value, $Res Function(_$BadgeEntityImpl) then) =
      __$$BadgeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String iconUrl,
      String category,
      DateTime earnedAt,
      int? level,
      bool? isRare});
}

/// @nodoc
class __$$BadgeEntityImplCopyWithImpl<$Res>
    extends _$BadgeEntityCopyWithImpl<$Res, _$BadgeEntityImpl>
    implements _$$BadgeEntityImplCopyWith<$Res> {
  __$$BadgeEntityImplCopyWithImpl(
      _$BadgeEntityImpl _value, $Res Function(_$BadgeEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? iconUrl = null,
    Object? category = null,
    Object? earnedAt = null,
    Object? level = freezed,
    Object? isRare = freezed,
  }) {
    return _then(_$BadgeEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      earnedAt: null == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      isRare: freezed == isRare
          ? _value.isRare
          : isRare // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$BadgeEntityImpl extends _BadgeEntity {
  const _$BadgeEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.iconUrl,
      required this.category,
      required this.earnedAt,
      this.level,
      this.isRare})
      : super._();

  /// ID único de la insignia.
  @override
  final String id;

  /// Nombre visible del logro.
  @override
  final String name;

  /// Descripción de cómo se obtuvo.
  @override
  final String description;

  /// URL del icono visual.
  @override
  final String iconUrl;

  /// Categoría del logro.
  /// Valores: 'karma', 'content', 'community', 'special'.
  @override
  final String category;

  /// Fecha de obtención.
  @override
  final DateTime earnedAt;

  /// Nivel de la insignia (1=Bronce, 2=Plata, 3=Oro).
  @override
  final int? level;

  /// Indica si es una insignia de evento limitado o difícil de conseguir.
  @override
  final bool? isRare;

  @override
  String toString() {
    return 'BadgeEntity(id: $id, name: $name, description: $description, iconUrl: $iconUrl, category: $category, earnedAt: $earnedAt, level: $level, isRare: $isRare)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.isRare, isRare) || other.isRare == isRare));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, iconUrl,
      category, earnedAt, level, isRare);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeEntityImplCopyWith<_$BadgeEntityImpl> get copyWith =>
      __$$BadgeEntityImplCopyWithImpl<_$BadgeEntityImpl>(this, _$identity);
}

abstract class _BadgeEntity extends BadgeEntity {
  const factory _BadgeEntity(
      {required final String id,
      required final String name,
      required final String description,
      required final String iconUrl,
      required final String category,
      required final DateTime earnedAt,
      final int? level,
      final bool? isRare}) = _$BadgeEntityImpl;
  const _BadgeEntity._() : super._();

  @override

  /// ID único de la insignia.
  String get id;
  @override

  /// Nombre visible del logro.
  String get name;
  @override

  /// Descripción de cómo se obtuvo.
  String get description;
  @override

  /// URL del icono visual.
  String get iconUrl;
  @override

  /// Categoría del logro.
  /// Valores: 'karma', 'content', 'community', 'special'.
  String get category;
  @override

  /// Fecha de obtención.
  DateTime get earnedAt;
  @override

  /// Nivel de la insignia (1=Bronce, 2=Plata, 3=Oro).
  int? get level;
  @override

  /// Indica si es una insignia de evento limitado o difícil de conseguir.
  bool? get isRare;
  @override
  @JsonKey(ignore: true)
  _$$BadgeEntityImplCopyWith<_$BadgeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
