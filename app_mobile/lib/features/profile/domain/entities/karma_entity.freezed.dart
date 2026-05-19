// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'karma_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KarmaEntity {
  /// Puntuación total acumulada (0 - 1000+).
  int get totalScore => throw _privateConstructorUsedError;

  /// Puntuación por ser real y verificar identidad.
  int get authenticityScore => throw _privateConstructorUsedError;

  /// Puntuación por crear contenido de valor.
  int get contributionScore => throw _privateConstructorUsedError;

  /// Puntuación por ayudar a otros y comentar positivamente.
  int get communityScore => throw _privateConstructorUsedError;

  /// Puntuación por actividad regular.
  int get consistencyScore => throw _privateConstructorUsedError;

  /// Nivel actual.
  /// Valores: 'newcomer', 'established', 'verified', 'legendary', 'suspicious'.
  String get tier => throw _privateConstructorUsedError;

  /// Progreso hacia el siguiente nivel (0.0 - 1.0).
  double get tierProgress => throw _privateConstructorUsedError;

  /// Privilegios desbloqueados basados en el Tier.
  List<String> get privileges => throw _privateConstructorUsedError;

  /// Ranking global (opcional).
  int? get rank => throw _privateConstructorUsedError;

  /// Cambio semanal en puntos (opcional).
  int? get weeklyChange => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KarmaEntityCopyWith<KarmaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KarmaEntityCopyWith<$Res> {
  factory $KarmaEntityCopyWith(
          KarmaEntity value, $Res Function(KarmaEntity) then) =
      _$KarmaEntityCopyWithImpl<$Res, KarmaEntity>;
  @useResult
  $Res call(
      {int totalScore,
      int authenticityScore,
      int contributionScore,
      int communityScore,
      int consistencyScore,
      String tier,
      double tierProgress,
      List<String> privileges,
      int? rank,
      int? weeklyChange});
}

/// @nodoc
class _$KarmaEntityCopyWithImpl<$Res, $Val extends KarmaEntity>
    implements $KarmaEntityCopyWith<$Res> {
  _$KarmaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalScore = null,
    Object? authenticityScore = null,
    Object? contributionScore = null,
    Object? communityScore = null,
    Object? consistencyScore = null,
    Object? tier = null,
    Object? tierProgress = null,
    Object? privileges = null,
    Object? rank = freezed,
    Object? weeklyChange = freezed,
  }) {
    return _then(_value.copyWith(
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      authenticityScore: null == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as int,
      contributionScore: null == contributionScore
          ? _value.contributionScore
          : contributionScore // ignore: cast_nullable_to_non_nullable
              as int,
      communityScore: null == communityScore
          ? _value.communityScore
          : communityScore // ignore: cast_nullable_to_non_nullable
              as int,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as int,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
      tierProgress: null == tierProgress
          ? _value.tierProgress
          : tierProgress // ignore: cast_nullable_to_non_nullable
              as double,
      privileges: null == privileges
          ? _value.privileges
          : privileges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      weeklyChange: freezed == weeklyChange
          ? _value.weeklyChange
          : weeklyChange // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KarmaEntityImplCopyWith<$Res>
    implements $KarmaEntityCopyWith<$Res> {
  factory _$$KarmaEntityImplCopyWith(
          _$KarmaEntityImpl value, $Res Function(_$KarmaEntityImpl) then) =
      __$$KarmaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalScore,
      int authenticityScore,
      int contributionScore,
      int communityScore,
      int consistencyScore,
      String tier,
      double tierProgress,
      List<String> privileges,
      int? rank,
      int? weeklyChange});
}

/// @nodoc
class __$$KarmaEntityImplCopyWithImpl<$Res>
    extends _$KarmaEntityCopyWithImpl<$Res, _$KarmaEntityImpl>
    implements _$$KarmaEntityImplCopyWith<$Res> {
  __$$KarmaEntityImplCopyWithImpl(
      _$KarmaEntityImpl _value, $Res Function(_$KarmaEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalScore = null,
    Object? authenticityScore = null,
    Object? contributionScore = null,
    Object? communityScore = null,
    Object? consistencyScore = null,
    Object? tier = null,
    Object? tierProgress = null,
    Object? privileges = null,
    Object? rank = freezed,
    Object? weeklyChange = freezed,
  }) {
    return _then(_$KarmaEntityImpl(
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      authenticityScore: null == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as int,
      contributionScore: null == contributionScore
          ? _value.contributionScore
          : contributionScore // ignore: cast_nullable_to_non_nullable
              as int,
      communityScore: null == communityScore
          ? _value.communityScore
          : communityScore // ignore: cast_nullable_to_non_nullable
              as int,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as int,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
      tierProgress: null == tierProgress
          ? _value.tierProgress
          : tierProgress // ignore: cast_nullable_to_non_nullable
              as double,
      privileges: null == privileges
          ? _value._privileges
          : privileges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rank: freezed == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int?,
      weeklyChange: freezed == weeklyChange
          ? _value.weeklyChange
          : weeklyChange // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$KarmaEntityImpl extends _KarmaEntity {
  const _$KarmaEntityImpl(
      {required this.totalScore,
      required this.authenticityScore,
      required this.contributionScore,
      required this.communityScore,
      required this.consistencyScore,
      required this.tier,
      required this.tierProgress,
      required final List<String> privileges,
      this.rank,
      this.weeklyChange})
      : _privileges = privileges,
        super._();

  /// Puntuación total acumulada (0 - 1000+).
  @override
  final int totalScore;

  /// Puntuación por ser real y verificar identidad.
  @override
  final int authenticityScore;

  /// Puntuación por crear contenido de valor.
  @override
  final int contributionScore;

  /// Puntuación por ayudar a otros y comentar positivamente.
  @override
  final int communityScore;

  /// Puntuación por actividad regular.
  @override
  final int consistencyScore;

  /// Nivel actual.
  /// Valores: 'newcomer', 'established', 'verified', 'legendary', 'suspicious'.
  @override
  final String tier;

  /// Progreso hacia el siguiente nivel (0.0 - 1.0).
  @override
  final double tierProgress;

  /// Privilegios desbloqueados basados en el Tier.
  final List<String> _privileges;

  /// Privilegios desbloqueados basados en el Tier.
  @override
  List<String> get privileges {
    if (_privileges is EqualUnmodifiableListView) return _privileges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_privileges);
  }

  /// Ranking global (opcional).
  @override
  final int? rank;

  /// Cambio semanal en puntos (opcional).
  @override
  final int? weeklyChange;

  @override
  String toString() {
    return 'KarmaEntity(totalScore: $totalScore, authenticityScore: $authenticityScore, contributionScore: $contributionScore, communityScore: $communityScore, consistencyScore: $consistencyScore, tier: $tier, tierProgress: $tierProgress, privileges: $privileges, rank: $rank, weeklyChange: $weeklyChange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KarmaEntityImpl &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.authenticityScore, authenticityScore) ||
                other.authenticityScore == authenticityScore) &&
            (identical(other.contributionScore, contributionScore) ||
                other.contributionScore == contributionScore) &&
            (identical(other.communityScore, communityScore) ||
                other.communityScore == communityScore) &&
            (identical(other.consistencyScore, consistencyScore) ||
                other.consistencyScore == consistencyScore) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.tierProgress, tierProgress) ||
                other.tierProgress == tierProgress) &&
            const DeepCollectionEquality()
                .equals(other._privileges, _privileges) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.weeklyChange, weeklyChange) ||
                other.weeklyChange == weeklyChange));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalScore,
      authenticityScore,
      contributionScore,
      communityScore,
      consistencyScore,
      tier,
      tierProgress,
      const DeepCollectionEquality().hash(_privileges),
      rank,
      weeklyChange);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KarmaEntityImplCopyWith<_$KarmaEntityImpl> get copyWith =>
      __$$KarmaEntityImplCopyWithImpl<_$KarmaEntityImpl>(this, _$identity);
}

abstract class _KarmaEntity extends KarmaEntity {
  const factory _KarmaEntity(
      {required final int totalScore,
      required final int authenticityScore,
      required final int contributionScore,
      required final int communityScore,
      required final int consistencyScore,
      required final String tier,
      required final double tierProgress,
      required final List<String> privileges,
      final int? rank,
      final int? weeklyChange}) = _$KarmaEntityImpl;
  const _KarmaEntity._() : super._();

  @override

  /// Puntuación total acumulada (0 - 1000+).
  int get totalScore;
  @override

  /// Puntuación por ser real y verificar identidad.
  int get authenticityScore;
  @override

  /// Puntuación por crear contenido de valor.
  int get contributionScore;
  @override

  /// Puntuación por ayudar a otros y comentar positivamente.
  int get communityScore;
  @override

  /// Puntuación por actividad regular.
  int get consistencyScore;
  @override

  /// Nivel actual.
  /// Valores: 'newcomer', 'established', 'verified', 'legendary', 'suspicious'.
  String get tier;
  @override

  /// Progreso hacia el siguiente nivel (0.0 - 1.0).
  double get tierProgress;
  @override

  /// Privilegios desbloqueados basados en el Tier.
  List<String> get privileges;
  @override

  /// Ranking global (opcional).
  int? get rank;
  @override

  /// Cambio semanal en puntos (opcional).
  int? get weeklyChange;
  @override
  @JsonKey(ignore: true)
  _$$KarmaEntityImplCopyWith<_$KarmaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
