// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vibes_dashboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VibesDashboardModel _$VibesDashboardModelFromJson(Map<String, dynamic> json) {
  return _VibesDashboardModel.fromJson(json);
}

/// @nodoc
mixin _$VibesDashboardModel {
  String get userId => throw _privateConstructorUsedError;
  double get vibeScore => throw _privateConstructorUsedError;
  Map<String, double> get emotions => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VibesDashboardModelCopyWith<VibesDashboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VibesDashboardModelCopyWith<$Res> {
  factory $VibesDashboardModelCopyWith(
          VibesDashboardModel value, $Res Function(VibesDashboardModel) then) =
      _$VibesDashboardModelCopyWithImpl<$Res, VibesDashboardModel>;
  @useResult
  $Res call(
      {String userId,
      double vibeScore,
      Map<String, double> emotions,
      DateTime timestamp});
}

/// @nodoc
class _$VibesDashboardModelCopyWithImpl<$Res, $Val extends VibesDashboardModel>
    implements $VibesDashboardModelCopyWith<$Res> {
  _$VibesDashboardModelCopyWithImpl(this._value, this._then);

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
abstract class _$$VibesDashboardModelImplCopyWith<$Res>
    implements $VibesDashboardModelCopyWith<$Res> {
  factory _$$VibesDashboardModelImplCopyWith(_$VibesDashboardModelImpl value,
          $Res Function(_$VibesDashboardModelImpl) then) =
      __$$VibesDashboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      double vibeScore,
      Map<String, double> emotions,
      DateTime timestamp});
}

/// @nodoc
class __$$VibesDashboardModelImplCopyWithImpl<$Res>
    extends _$VibesDashboardModelCopyWithImpl<$Res, _$VibesDashboardModelImpl>
    implements _$$VibesDashboardModelImplCopyWith<$Res> {
  __$$VibesDashboardModelImplCopyWithImpl(_$VibesDashboardModelImpl _value,
      $Res Function(_$VibesDashboardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? vibeScore = null,
    Object? emotions = null,
    Object? timestamp = null,
  }) {
    return _then(_$VibesDashboardModelImpl(
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
@JsonSerializable()
class _$VibesDashboardModelImpl extends _VibesDashboardModel {
  const _$VibesDashboardModelImpl(
      {required this.userId,
      required this.vibeScore,
      required final Map<String, double> emotions,
      required this.timestamp})
      : _emotions = emotions,
        super._();

  factory _$VibesDashboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VibesDashboardModelImplFromJson(json);

  @override
  final String userId;
  @override
  final double vibeScore;
  final Map<String, double> _emotions;
  @override
  Map<String, double> get emotions {
    if (_emotions is EqualUnmodifiableMapView) return _emotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emotions);
  }

  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'VibesDashboardModel(userId: $userId, vibeScore: $vibeScore, emotions: $emotions, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VibesDashboardModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.vibeScore, vibeScore) ||
                other.vibeScore == vibeScore) &&
            const DeepCollectionEquality().equals(other._emotions, _emotions) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, vibeScore,
      const DeepCollectionEquality().hash(_emotions), timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VibesDashboardModelImplCopyWith<_$VibesDashboardModelImpl> get copyWith =>
      __$$VibesDashboardModelImplCopyWithImpl<_$VibesDashboardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VibesDashboardModelImplToJson(
      this,
    );
  }
}

abstract class _VibesDashboardModel extends VibesDashboardModel {
  const factory _VibesDashboardModel(
      {required final String userId,
      required final double vibeScore,
      required final Map<String, double> emotions,
      required final DateTime timestamp}) = _$VibesDashboardModelImpl;
  const _VibesDashboardModel._() : super._();

  factory _VibesDashboardModel.fromJson(Map<String, dynamic> json) =
      _$VibesDashboardModelImpl.fromJson;

  @override
  String get userId;
  @override
  double get vibeScore;
  @override
  Map<String, double> get emotions;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$VibesDashboardModelImplCopyWith<_$VibesDashboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
