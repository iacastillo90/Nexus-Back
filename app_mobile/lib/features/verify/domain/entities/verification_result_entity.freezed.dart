// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerificationResultEntity {
  /// ID del contenido analizado.
  String get contentId => throw _privateConstructorUsedError;

  /// Hash único del contenido (Content DNA).
  String get contentDNA => throw _privateConstructorUsedError;

  /// Estado final del análisis.
  VerificationStatus get status => throw _privateConstructorUsedError;

  /// Puntuación de autenticidad (0-100).
  /// 100 = Totalmente original.
  double get authenticityScore => throw _privateConstructorUsedError;

  /// Fecha de verificación.
  DateTime get verifiedAt => throw _privateConstructorUsedError;

  /// Autor original detectado (si es un repost).
  String? get originalAuthor => throw _privateConstructorUsedError;

  /// Fuente original (URL/Plataforma).
  String? get originalSource => throw _privateConstructorUsedError;

  /// Fecha de publicación original.
  DateTime? get originalDate => throw _privateConstructorUsedError;

  /// Lista de alteraciones detectadas (ej: "Face swap", "Audio noise").
  List<String> get modifications => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VerificationResultEntityCopyWith<VerificationResultEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationResultEntityCopyWith<$Res> {
  factory $VerificationResultEntityCopyWith(VerificationResultEntity value,
          $Res Function(VerificationResultEntity) then) =
      _$VerificationResultEntityCopyWithImpl<$Res, VerificationResultEntity>;
  @useResult
  $Res call(
      {String contentId,
      String contentDNA,
      VerificationStatus status,
      double authenticityScore,
      DateTime verifiedAt,
      String? originalAuthor,
      String? originalSource,
      DateTime? originalDate,
      List<String> modifications});
}

/// @nodoc
class _$VerificationResultEntityCopyWithImpl<$Res,
        $Val extends VerificationResultEntity>
    implements $VerificationResultEntityCopyWith<$Res> {
  _$VerificationResultEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? contentDNA = null,
    Object? status = null,
    Object? authenticityScore = null,
    Object? verifiedAt = null,
    Object? originalAuthor = freezed,
    Object? originalSource = freezed,
    Object? originalDate = freezed,
    Object? modifications = null,
  }) {
    return _then(_value.copyWith(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentDNA: null == contentDNA
          ? _value.contentDNA
          : contentDNA // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      authenticityScore: null == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as double,
      verifiedAt: null == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originalAuthor: freezed == originalAuthor
          ? _value.originalAuthor
          : originalAuthor // ignore: cast_nullable_to_non_nullable
              as String?,
      originalSource: freezed == originalSource
          ? _value.originalSource
          : originalSource // ignore: cast_nullable_to_non_nullable
              as String?,
      originalDate: freezed == originalDate
          ? _value.originalDate
          : originalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifications: null == modifications
          ? _value.modifications
          : modifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationResultEntityImplCopyWith<$Res>
    implements $VerificationResultEntityCopyWith<$Res> {
  factory _$$VerificationResultEntityImplCopyWith(
          _$VerificationResultEntityImpl value,
          $Res Function(_$VerificationResultEntityImpl) then) =
      __$$VerificationResultEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String contentId,
      String contentDNA,
      VerificationStatus status,
      double authenticityScore,
      DateTime verifiedAt,
      String? originalAuthor,
      String? originalSource,
      DateTime? originalDate,
      List<String> modifications});
}

/// @nodoc
class __$$VerificationResultEntityImplCopyWithImpl<$Res>
    extends _$VerificationResultEntityCopyWithImpl<$Res,
        _$VerificationResultEntityImpl>
    implements _$$VerificationResultEntityImplCopyWith<$Res> {
  __$$VerificationResultEntityImplCopyWithImpl(
      _$VerificationResultEntityImpl _value,
      $Res Function(_$VerificationResultEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentId = null,
    Object? contentDNA = null,
    Object? status = null,
    Object? authenticityScore = null,
    Object? verifiedAt = null,
    Object? originalAuthor = freezed,
    Object? originalSource = freezed,
    Object? originalDate = freezed,
    Object? modifications = null,
  }) {
    return _then(_$VerificationResultEntityImpl(
      contentId: null == contentId
          ? _value.contentId
          : contentId // ignore: cast_nullable_to_non_nullable
              as String,
      contentDNA: null == contentDNA
          ? _value.contentDNA
          : contentDNA // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      authenticityScore: null == authenticityScore
          ? _value.authenticityScore
          : authenticityScore // ignore: cast_nullable_to_non_nullable
              as double,
      verifiedAt: null == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      originalAuthor: freezed == originalAuthor
          ? _value.originalAuthor
          : originalAuthor // ignore: cast_nullable_to_non_nullable
              as String?,
      originalSource: freezed == originalSource
          ? _value.originalSource
          : originalSource // ignore: cast_nullable_to_non_nullable
              as String?,
      originalDate: freezed == originalDate
          ? _value.originalDate
          : originalDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifications: null == modifications
          ? _value._modifications
          : modifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$VerificationResultEntityImpl extends _VerificationResultEntity {
  const _$VerificationResultEntityImpl(
      {required this.contentId,
      required this.contentDNA,
      required this.status,
      required this.authenticityScore,
      required this.verifiedAt,
      this.originalAuthor,
      this.originalSource,
      this.originalDate,
      final List<String> modifications = const []})
      : _modifications = modifications,
        super._();

  /// ID del contenido analizado.
  @override
  final String contentId;

  /// Hash único del contenido (Content DNA).
  @override
  final String contentDNA;

  /// Estado final del análisis.
  @override
  final VerificationStatus status;

  /// Puntuación de autenticidad (0-100).
  /// 100 = Totalmente original.
  @override
  final double authenticityScore;

  /// Fecha de verificación.
  @override
  final DateTime verifiedAt;

  /// Autor original detectado (si es un repost).
  @override
  final String? originalAuthor;

  /// Fuente original (URL/Plataforma).
  @override
  final String? originalSource;

  /// Fecha de publicación original.
  @override
  final DateTime? originalDate;

  /// Lista de alteraciones detectadas (ej: "Face swap", "Audio noise").
  final List<String> _modifications;

  /// Lista de alteraciones detectadas (ej: "Face swap", "Audio noise").
  @override
  @JsonKey()
  List<String> get modifications {
    if (_modifications is EqualUnmodifiableListView) return _modifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modifications);
  }

  @override
  String toString() {
    return 'VerificationResultEntity(contentId: $contentId, contentDNA: $contentDNA, status: $status, authenticityScore: $authenticityScore, verifiedAt: $verifiedAt, originalAuthor: $originalAuthor, originalSource: $originalSource, originalDate: $originalDate, modifications: $modifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationResultEntityImpl &&
            (identical(other.contentId, contentId) ||
                other.contentId == contentId) &&
            (identical(other.contentDNA, contentDNA) ||
                other.contentDNA == contentDNA) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.authenticityScore, authenticityScore) ||
                other.authenticityScore == authenticityScore) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt) &&
            (identical(other.originalAuthor, originalAuthor) ||
                other.originalAuthor == originalAuthor) &&
            (identical(other.originalSource, originalSource) ||
                other.originalSource == originalSource) &&
            (identical(other.originalDate, originalDate) ||
                other.originalDate == originalDate) &&
            const DeepCollectionEquality()
                .equals(other._modifications, _modifications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      contentId,
      contentDNA,
      status,
      authenticityScore,
      verifiedAt,
      originalAuthor,
      originalSource,
      originalDate,
      const DeepCollectionEquality().hash(_modifications));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationResultEntityImplCopyWith<_$VerificationResultEntityImpl>
      get copyWith => __$$VerificationResultEntityImplCopyWithImpl<
          _$VerificationResultEntityImpl>(this, _$identity);
}

abstract class _VerificationResultEntity extends VerificationResultEntity {
  const factory _VerificationResultEntity(
      {required final String contentId,
      required final String contentDNA,
      required final VerificationStatus status,
      required final double authenticityScore,
      required final DateTime verifiedAt,
      final String? originalAuthor,
      final String? originalSource,
      final DateTime? originalDate,
      final List<String> modifications}) = _$VerificationResultEntityImpl;
  const _VerificationResultEntity._() : super._();

  @override

  /// ID del contenido analizado.
  String get contentId;
  @override

  /// Hash único del contenido (Content DNA).
  String get contentDNA;
  @override

  /// Estado final del análisis.
  VerificationStatus get status;
  @override

  /// Puntuación de autenticidad (0-100).
  /// 100 = Totalmente original.
  double get authenticityScore;
  @override

  /// Fecha de verificación.
  DateTime get verifiedAt;
  @override

  /// Autor original detectado (si es un repost).
  String? get originalAuthor;
  @override

  /// Fuente original (URL/Plataforma).
  String? get originalSource;
  @override

  /// Fecha de publicación original.
  DateTime? get originalDate;
  @override

  /// Lista de alteraciones detectadas (ej: "Face swap", "Audio noise").
  List<String> get modifications;
  @override
  @JsonKey(ignore: true)
  _$$VerificationResultEntityImplCopyWith<_$VerificationResultEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
