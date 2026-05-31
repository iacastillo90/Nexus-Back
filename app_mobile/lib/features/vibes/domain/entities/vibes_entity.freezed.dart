// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vibes_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VibesEntity {
  /// ID del usuario analizado.
  String get userId => throw _privateConstructorUsedError;

  /// Puntuación general de vibra (0-100).
  /// Altas puntuaciones indican positividad/energía.
  double get vibeScore => throw _privateConstructorUsedError;

  /// Mapa de emociones detectadas y su intensidad (0.0 - 1.0).
  /// Keys: 'joy', 'anger', 'sadness', 'fear', 'surprise'.
  Map<String, double> get emotions => throw _privateConstructorUsedError;

  /// Fecha del análisis.
  DateTime get timestamp => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VibesEntityCopyWith<VibesEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VibesEntityCopyWith<$Res> {
  factory $VibesEntityCopyWith(
          VibesEntity value, $Res Function(VibesEntity) then) =
      _$VibesEntityCopyWithImpl<$Res, VibesEntity>;
  @useResult
  $Res call(
      {String userId,
      double vibeScore,
      Map<String, double> emotions,
      DateTime timestamp});
}

/// @nodoc
class _$VibesEntityCopyWithImpl<$Res, $Val extends VibesEntity>
    implements $VibesEntityCopyWith<$Res> {
  _$VibesEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? vibeScore = null,
    Object? emotions = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      vibeScore: null == vibeScore
          ? _value.vibeScore
          : vibeScore // ignore: cast_nullable_to_non_nullable
              as double,
      emotions: null == emotions
          ? _value.emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VibesEntityImplCopyWith<$Res>
    implements $VibesEntityCopyWith<$Res> {
  factory _$$VibesEntityImplCopyWith(
          _$VibesEntityImpl value, $Res Function(_$VibesEntityImpl) then) =
      __$$VibesEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      double vibeScore,
      Map<String, double> emotions,
      DateTime timestamp});
}

/// @nodoc
class __$$VibesEntityImplCopyWithImpl<$Res>
    extends _$VibesEntityCopyWithImpl<$Res, _$VibesEntityImpl>
    implements _$$VibesEntityImplCopyWith<$Res> {
  __$$VibesEntityImplCopyWithImpl(
      _$VibesEntityImpl _value, $Res Function(_$VibesEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? vibeScore = null,
    Object? emotions = null,
    Object? timestamp = null,
  }) {
    return _then(_$VibesEntityImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      vibeScore: null == vibeScore
          ? _value.vibeScore
          : vibeScore // ignore: cast_nullable_to_non_nullable
              as double,
      emotions: null == emotions
          ? _value._emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$VibesEntityImpl extends _VibesEntity {
  const _$VibesEntityImpl(
      {required this.userId,
      required this.vibeScore,
      required final Map<String, double> emotions,
      required this.timestamp})
      : _emotions = emotions,
        super._();

  /// ID del usuario analizado.
  @override
  final String userId;

  /// Puntuación general de vibra (0-100).
  /// Altas puntuaciones indican positividad/energía.
  @override
  final double vibeScore;

  /// Mapa de emociones detectadas y su intensidad (0.0 - 1.0).
  /// Keys: 'joy', 'anger', 'sadness', 'fear', 'surprise'.
  final Map<String, double> _emotions;

  /// Mapa de emociones detectadas y su intensidad (0.0 - 1.0).
  /// Keys: 'joy', 'anger', 'sadness', 'fear', 'surprise'.
  @override
  Map<String, double> get emotions {
    if (_emotions is EqualUnmodifiableMapView) return _emotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emotions);
  }

  /// Fecha del análisis.
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'VibesEntity(userId: $userId, vibeScore: $vibeScore, emotions: $emotions, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VibesEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.vibeScore, vibeScore) ||
                other.vibeScore == vibeScore) &&
            const DeepCollectionEquality().equals(other._emotions, _emotions) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, vibeScore,
      const DeepCollectionEquality().hash(_emotions), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VibesEntityImplCopyWith<_$VibesEntityImpl> get copyWith =>
      __$$VibesEntityImplCopyWithImpl<_$VibesEntityImpl>(this, _$identity);
}

abstract class _VibesEntity extends VibesEntity {
  const factory _VibesEntity(
      {required final String userId,
      required final double vibeScore,
      required final Map<String, double> emotions,
      required final DateTime timestamp}) = _$VibesEntityImpl;
  const _VibesEntity._() : super._();

  @override

  /// ID del usuario analizado.
  String get userId;
  @override

  /// Puntuación general de vibra (0-100).
  /// Altas puntuaciones indican positividad/energía.
  double get vibeScore;
  @override

  /// Mapa de emociones detectadas y su intensidad (0.0 - 1.0).
  /// Keys: 'joy', 'anger', 'sadness', 'fear', 'surprise'.
  Map<String, double> get emotions;
  @override

  /// Fecha del análisis.
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$VibesEntityImplCopyWith<_$VibesEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
