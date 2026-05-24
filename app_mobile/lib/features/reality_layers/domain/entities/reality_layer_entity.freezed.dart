// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reality_layer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RealityLayerEntity {
  /// ID único de la capa (slug: 'tech', 'art').
  String get id => throw _privateConstructorUsedError;

  /// Nombre visible.
  String get name => throw _privateConstructorUsedError;

  /// Descripción de la temática.
  String get description => throw _privateConstructorUsedError;

  /// Nombre del icono (string para mapeo).
  String get icon => throw _privateConstructorUsedError;

  /// Color base en Hex.
  String get colorHex => throw _privateConstructorUsedError;

  /// Cantidad de posts activos en esta capa.
  int get postCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RealityLayerEntityCopyWith<RealityLayerEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RealityLayerEntityCopyWith<$Res> {
  factory $RealityLayerEntityCopyWith(
          RealityLayerEntity value, $Res Function(RealityLayerEntity) then) =
      _$RealityLayerEntityCopyWithImpl<$Res, RealityLayerEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String icon,
      String colorHex,
      int postCount});
}

/// @nodoc
class _$RealityLayerEntityCopyWithImpl<$Res, $Val extends RealityLayerEntity>
    implements $RealityLayerEntityCopyWith<$Res> {
  _$RealityLayerEntityCopyWithImpl(this._value, this._then);

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
    Object? icon = null,
    Object? colorHex = null,
    Object? postCount = null,
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RealityLayerEntityImplCopyWith<$Res>
    implements $RealityLayerEntityCopyWith<$Res> {
  factory _$$RealityLayerEntityImplCopyWith(_$RealityLayerEntityImpl value,
          $Res Function(_$RealityLayerEntityImpl) then) =
      __$$RealityLayerEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String icon,
      String colorHex,
      int postCount});
}

/// @nodoc
class __$$RealityLayerEntityImplCopyWithImpl<$Res>
    extends _$RealityLayerEntityCopyWithImpl<$Res, _$RealityLayerEntityImpl>
    implements _$$RealityLayerEntityImplCopyWith<$Res> {
  __$$RealityLayerEntityImplCopyWithImpl(_$RealityLayerEntityImpl _value,
      $Res Function(_$RealityLayerEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = null,
    Object? colorHex = null,
    Object? postCount = null,
  }) {
    return _then(_$RealityLayerEntityImpl(
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
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      postCount: null == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RealityLayerEntityImpl extends _RealityLayerEntity {
  const _$RealityLayerEntityImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.icon,
      required this.colorHex,
      this.postCount = 0})
      : super._();

  /// ID único de la capa (slug: 'tech', 'art').
  @override
  final String id;

  /// Nombre visible.
  @override
  final String name;

  /// Descripción de la temática.
  @override
  final String description;

  /// Nombre del icono (string para mapeo).
  @override
  final String icon;

  /// Color base en Hex.
  @override
  final String colorHex;

  /// Cantidad de posts activos en esta capa.
  @override
  @JsonKey()
  final int postCount;

  @override
  String toString() {
    return 'RealityLayerEntity(id: $id, name: $name, description: $description, icon: $icon, colorHex: $colorHex, postCount: $postCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RealityLayerEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, icon, colorHex, postCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RealityLayerEntityImplCopyWith<_$RealityLayerEntityImpl> get copyWith =>
      __$$RealityLayerEntityImplCopyWithImpl<_$RealityLayerEntityImpl>(
          this, _$identity);
}

abstract class _RealityLayerEntity extends RealityLayerEntity {
  const factory _RealityLayerEntity(
      {required final String id,
      required final String name,
      required final String description,
      required final String icon,
      required final String colorHex,
      final int postCount}) = _$RealityLayerEntityImpl;
  const _RealityLayerEntity._() : super._();

  @override

  /// ID único de la capa (slug: 'tech', 'art').
  String get id;
  @override

  /// Nombre visible.
  String get name;
  @override

  /// Descripción de la temática.
  String get description;
  @override

  /// Nombre del icono (string para mapeo).
  String get icon;
  @override

  /// Color base en Hex.
  String get colorHex;
  @override

  /// Cantidad de posts activos en esta capa.
  int get postCount;
  @override
  @JsonKey(ignore: true)
  _$$RealityLayerEntityImplCopyWith<_$RealityLayerEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
