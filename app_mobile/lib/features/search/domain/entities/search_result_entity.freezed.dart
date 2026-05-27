// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchResultEntity {
  /// ID del objeto encontrado (User ID, Post ID, Tag Name).
  String get id => throw _privateConstructorUsedError;

  /// Tipo de entidad (User, Post, Tag).
  SearchResultType get type => throw _privateConstructorUsedError;

  /// Título principal (Username, Post Title, Hashtag).
  String get title => throw _privateConstructorUsedError;

  /// Subtítulo descriptivo (Bio, Snippet, Count).
  String get subtitle => throw _privateConstructorUsedError;

  /// URL de imagen asociada (Avatar, Thumbnail).
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Datos extra específicos del tipo (followers, likes, etc.).
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchResultEntityCopyWith<SearchResultEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchResultEntityCopyWith<$Res> {
  factory $SearchResultEntityCopyWith(
          SearchResultEntity value, $Res Function(SearchResultEntity) then) =
      _$SearchResultEntityCopyWithImpl<$Res, SearchResultEntity>;
  @useResult
  $Res call(
      {String id,
      SearchResultType type,
      String title,
      String subtitle,
      String? imageUrl,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$SearchResultEntityCopyWithImpl<$Res, $Val extends SearchResultEntity>
    implements $SearchResultEntityCopyWith<$Res> {
  _$SearchResultEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchResultType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchResultEntityImplCopyWith<$Res>
    implements $SearchResultEntityCopyWith<$Res> {
  factory _$$SearchResultEntityImplCopyWith(_$SearchResultEntityImpl value,
          $Res Function(_$SearchResultEntityImpl) then) =
      __$$SearchResultEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      SearchResultType type,
      String title,
      String subtitle,
      String? imageUrl,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$SearchResultEntityImplCopyWithImpl<$Res>
    extends _$SearchResultEntityCopyWithImpl<$Res, _$SearchResultEntityImpl>
    implements _$$SearchResultEntityImplCopyWith<$Res> {
  __$$SearchResultEntityImplCopyWithImpl(_$SearchResultEntityImpl _value,
      $Res Function(_$SearchResultEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$SearchResultEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SearchResultType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$SearchResultEntityImpl extends _SearchResultEntity {
  const _$SearchResultEntityImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.subtitle,
      this.imageUrl,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata,
        super._();

  /// ID del objeto encontrado (User ID, Post ID, Tag Name).
  @override
  final String id;

  /// Tipo de entidad (User, Post, Tag).
  @override
  final SearchResultType type;

  /// Título principal (Username, Post Title, Hashtag).
  @override
  final String title;

  /// Subtítulo descriptivo (Bio, Snippet, Count).
  @override
  final String subtitle;

  /// URL de imagen asociada (Avatar, Thumbnail).
  @override
  final String? imageUrl;

  /// Datos extra específicos del tipo (followers, likes, etc.).
  final Map<String, dynamic>? _metadata;

  /// Datos extra específicos del tipo (followers, likes, etc.).
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SearchResultEntity(id: $id, type: $type, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchResultEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, type, title, subtitle,
      imageUrl, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchResultEntityImplCopyWith<_$SearchResultEntityImpl> get copyWith =>
      __$$SearchResultEntityImplCopyWithImpl<_$SearchResultEntityImpl>(
          this, _$identity);
}

abstract class _SearchResultEntity extends SearchResultEntity {
  const factory _SearchResultEntity(
      {required final String id,
      required final SearchResultType type,
      required final String title,
      required final String subtitle,
      final String? imageUrl,
      final Map<String, dynamic>? metadata}) = _$SearchResultEntityImpl;
  const _SearchResultEntity._() : super._();

  @override

  /// ID del objeto encontrado (User ID, Post ID, Tag Name).
  String get id;
  @override

  /// Tipo de entidad (User, Post, Tag).
  SearchResultType get type;
  @override

  /// Título principal (Username, Post Title, Hashtag).
  String get title;
  @override

  /// Subtítulo descriptivo (Bio, Snippet, Count).
  String get subtitle;
  @override

  /// URL de imagen asociada (Avatar, Thumbnail).
  String? get imageUrl;
  @override

  /// Datos extra específicos del tipo (followers, likes, etc.).
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$SearchResultEntityImplCopyWith<_$SearchResultEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
