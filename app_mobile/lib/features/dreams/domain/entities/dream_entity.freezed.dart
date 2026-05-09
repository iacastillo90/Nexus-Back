// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DreamEntity {
  /// ID único del sueño.
  String get id => throw _privateConstructorUsedError;

  /// Título creativo de la historia.
  String get title => throw _privateConstructorUsedError;

  /// Premisa o semilla inicial.
  String get description => throw _privateConstructorUsedError;

  /// ID del creador original.
  String get creatorId => throw _privateConstructorUsedError;

  /// Nombre del creador (caché).
  String get creatorName => throw _privateConstructorUsedError;

  /// Avatar del creador (caché).
  String? get creatorAvatar => throw _privateConstructorUsedError;

  /// Número máximo de partes permitidas.
  int get maxContributions => throw _privateConstructorUsedError;

  /// Número actual de partes escritas.
  int get currentContributions => throw _privateConstructorUsedError;

  /// Estado actual (Activo, Completado, Archivado).
  DreamStatus get status => throw _privateConstructorUsedError;

  /// Fecha de inicio.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Fecha de finalización (cuando se llenaron los slots).
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Etiquetas temáticas (ej: "Sci-Fi", "Horror").
  List<String> get tags => throw _privateConstructorUsedError;

  /// Contador de lecturas.
  int get viewCount => throw _privateConstructorUsedError;

  /// Contador de likes totales.
  int get likeCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DreamEntityCopyWith<DreamEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DreamEntityCopyWith<$Res> {
  factory $DreamEntityCopyWith(
          DreamEntity value, $Res Function(DreamEntity) then) =
      _$DreamEntityCopyWithImpl<$Res, DreamEntity>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String creatorId,
      String creatorName,
      String? creatorAvatar,
      int maxContributions,
      int currentContributions,
      DreamStatus status,
      DateTime createdAt,
      DateTime? completedAt,
      List<String> tags,
      int viewCount,
      int likeCount});
}

/// @nodoc
class _$DreamEntityCopyWithImpl<$Res, $Val extends DreamEntity>
    implements $DreamEntityCopyWith<$Res> {
  _$DreamEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? creatorId = null,
    Object? creatorName = null,
    Object? creatorAvatar = freezed,
    Object? maxContributions = null,
    Object? currentContributions = null,
    Object? status = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? tags = null,
    Object? viewCount = null,
    Object? likeCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorName: null == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String,
      creatorAvatar: freezed == creatorAvatar
          ? _value.creatorAvatar
          : creatorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      maxContributions: null == maxContributions
          ? _value.maxContributions
          : maxContributions // ignore: cast_nullable_to_non_nullable
              as int,
      currentContributions: null == currentContributions
          ? _value.currentContributions
          : currentContributions // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DreamStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DreamEntityImplCopyWith<$Res>
    implements $DreamEntityCopyWith<$Res> {
  factory _$$DreamEntityImplCopyWith(
          _$DreamEntityImpl value, $Res Function(_$DreamEntityImpl) then) =
      __$$DreamEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String creatorId,
      String creatorName,
      String? creatorAvatar,
      int maxContributions,
      int currentContributions,
      DreamStatus status,
      DateTime createdAt,
      DateTime? completedAt,
      List<String> tags,
      int viewCount,
      int likeCount});
}

/// @nodoc
class __$$DreamEntityImplCopyWithImpl<$Res>
    extends _$DreamEntityCopyWithImpl<$Res, _$DreamEntityImpl>
    implements _$$DreamEntityImplCopyWith<$Res> {
  __$$DreamEntityImplCopyWithImpl(
      _$DreamEntityImpl _value, $Res Function(_$DreamEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? creatorId = null,
    Object? creatorName = null,
    Object? creatorAvatar = freezed,
    Object? maxContributions = null,
    Object? currentContributions = null,
    Object? status = null,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? tags = null,
    Object? viewCount = null,
    Object? likeCount = null,
  }) {
    return _then(_$DreamEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: null == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      creatorName: null == creatorName
          ? _value.creatorName
          : creatorName // ignore: cast_nullable_to_non_nullable
              as String,
      creatorAvatar: freezed == creatorAvatar
          ? _value.creatorAvatar
          : creatorAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      maxContributions: null == maxContributions
          ? _value.maxContributions
          : maxContributions // ignore: cast_nullable_to_non_nullable
              as int,
      currentContributions: null == currentContributions
          ? _value.currentContributions
          : currentContributions // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DreamStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$DreamEntityImpl extends _DreamEntity {
  const _$DreamEntityImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.creatorId,
      required this.creatorName,
      this.creatorAvatar,
      required this.maxContributions,
      required this.currentContributions,
      required this.status,
      required this.createdAt,
      this.completedAt,
      final List<String> tags = const [],
      this.viewCount = 0,
      this.likeCount = 0})
      : _tags = tags,
        super._();

  /// ID único del sueño.
  @override
  final String id;

  /// Título creativo de la historia.
  @override
  final String title;

  /// Premisa o semilla inicial.
  @override
  final String description;

  /// ID del creador original.
  @override
  final String creatorId;

  /// Nombre del creador (caché).
  @override
  final String creatorName;

  /// Avatar del creador (caché).
  @override
  final String? creatorAvatar;

  /// Número máximo de partes permitidas.
  @override
  final int maxContributions;

  /// Número actual de partes escritas.
  @override
  final int currentContributions;

  /// Estado actual (Activo, Completado, Archivado).
  @override
  final DreamStatus status;

  /// Fecha de inicio.
  @override
  final DateTime createdAt;

  /// Fecha de finalización (cuando se llenaron los slots).
  @override
  final DateTime? completedAt;

  /// Etiquetas temáticas (ej: "Sci-Fi", "Horror").
  final List<String> _tags;

  /// Etiquetas temáticas (ej: "Sci-Fi", "Horror").
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Contador de lecturas.
  @override
  @JsonKey()
  final int viewCount;

  /// Contador de likes totales.
  @override
  @JsonKey()
  final int likeCount;

  @override
  String toString() {
    return 'DreamEntity(id: $id, title: $title, description: $description, creatorId: $creatorId, creatorName: $creatorName, creatorAvatar: $creatorAvatar, maxContributions: $maxContributions, currentContributions: $currentContributions, status: $status, createdAt: $createdAt, completedAt: $completedAt, tags: $tags, viewCount: $viewCount, likeCount: $likeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DreamEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.creatorName, creatorName) ||
                other.creatorName == creatorName) &&
            (identical(other.creatorAvatar, creatorAvatar) ||
                other.creatorAvatar == creatorAvatar) &&
            (identical(other.maxContributions, maxContributions) ||
                other.maxContributions == maxContributions) &&
            (identical(other.currentContributions, currentContributions) ||
                other.currentContributions == currentContributions) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      creatorId,
      creatorName,
      creatorAvatar,
      maxContributions,
      currentContributions,
      status,
      createdAt,
      completedAt,
      const DeepCollectionEquality().hash(_tags),
      viewCount,
      likeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DreamEntityImplCopyWith<_$DreamEntityImpl> get copyWith =>
      __$$DreamEntityImplCopyWithImpl<_$DreamEntityImpl>(this, _$identity);
}

abstract class _DreamEntity extends DreamEntity {
  const factory _DreamEntity(
      {required final String id,
      required final String title,
      required final String description,
      required final String creatorId,
      required final String creatorName,
      final String? creatorAvatar,
      required final int maxContributions,
      required final int currentContributions,
      required final DreamStatus status,
      required final DateTime createdAt,
      final DateTime? completedAt,
      final List<String> tags,
      final int viewCount,
      final int likeCount}) = _$DreamEntityImpl;
  const _DreamEntity._() : super._();

  @override

  /// ID único del sueño.
  String get id;
  @override

  /// Título creativo de la historia.
  String get title;
  @override

  /// Premisa o semilla inicial.
  String get description;
  @override

  /// ID del creador original.
  String get creatorId;
  @override

  /// Nombre del creador (caché).
  String get creatorName;
  @override

  /// Avatar del creador (caché).
  String? get creatorAvatar;
  @override

  /// Número máximo de partes permitidas.
  int get maxContributions;
  @override

  /// Número actual de partes escritas.
  int get currentContributions;
  @override

  /// Estado actual (Activo, Completado, Archivado).
  DreamStatus get status;
  @override

  /// Fecha de inicio.
  DateTime get createdAt;
  @override

  /// Fecha de finalización (cuando se llenaron los slots).
  DateTime? get completedAt;
  @override

  /// Etiquetas temáticas (ej: "Sci-Fi", "Horror").
  List<String> get tags;
  @override

  /// Contador de lecturas.
  int get viewCount;
  @override

  /// Contador de likes totales.
  int get likeCount;
  @override
  @JsonKey(ignore: true)
  _$$DreamEntityImplCopyWith<_$DreamEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
