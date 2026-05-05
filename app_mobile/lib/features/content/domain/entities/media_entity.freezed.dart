// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'media_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MediaEntity {
  /// URL pública del archivo (CDN o S3).
  String get url => throw _privateConstructorUsedError;

  /// Tipo de medio.
  /// Valores: 'image', 'video', 'audio'.
  String get type => throw _privateConstructorUsedError;

  /// URL de la miniatura (para videos).
  String? get thumbnailUrl => throw _privateConstructorUsedError;

  /// Ancho en píxeles (para imágenes/videos).
  int? get width => throw _privateConstructorUsedError;

  /// Alto en píxeles (para imágenes/videos).
  int? get height => throw _privateConstructorUsedError;

  /// Duración en segundos (para audio/video).
  int? get duration => throw _privateConstructorUsedError;

  /// Tamaño del archivo en bytes.
  int? get size => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaEntityCopyWith<MediaEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaEntityCopyWith<$Res> {
  factory $MediaEntityCopyWith(
          MediaEntity value, $Res Function(MediaEntity) then) =
      _$MediaEntityCopyWithImpl<$Res, MediaEntity>;
  @useResult
  $Res call(
      {String url,
      String type,
      String? thumbnailUrl,
      int? width,
      int? height,
      int? duration,
      int? size});
}

/// @nodoc
class _$MediaEntityCopyWithImpl<$Res, $Val extends MediaEntity>
    implements $MediaEntityCopyWith<$Res> {
  _$MediaEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? thumbnailUrl = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? duration = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediaEntityImplCopyWith<$Res>
    implements $MediaEntityCopyWith<$Res> {
  factory _$$MediaEntityImplCopyWith(
          _$MediaEntityImpl value, $Res Function(_$MediaEntityImpl) then) =
      __$$MediaEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String type,
      String? thumbnailUrl,
      int? width,
      int? height,
      int? duration,
      int? size});
}

/// @nodoc
class __$$MediaEntityImplCopyWithImpl<$Res>
    extends _$MediaEntityCopyWithImpl<$Res, _$MediaEntityImpl>
    implements _$$MediaEntityImplCopyWith<$Res> {
  __$$MediaEntityImplCopyWithImpl(
      _$MediaEntityImpl _value, $Res Function(_$MediaEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? type = null,
    Object? thumbnailUrl = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? duration = freezed,
    Object? size = freezed,
  }) {
    return _then(_$MediaEntityImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      duration: freezed == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$MediaEntityImpl extends _MediaEntity {
  const _$MediaEntityImpl(
      {required this.url,
      required this.type,
      this.thumbnailUrl,
      this.width,
      this.height,
      this.duration,
      this.size})
      : super._();

  /// URL pública del archivo (CDN o S3).
  @override
  final String url;

  /// Tipo de medio.
  /// Valores: 'image', 'video', 'audio'.
  @override
  final String type;

  /// URL de la miniatura (para videos).
  @override
  final String? thumbnailUrl;

  /// Ancho en píxeles (para imágenes/videos).
  @override
  final int? width;

  /// Alto en píxeles (para imágenes/videos).
  @override
  final int? height;

  /// Duración en segundos (para audio/video).
  @override
  final int? duration;

  /// Tamaño del archivo en bytes.
  @override
  final int? size;

  @override
  String toString() {
    return 'MediaEntity(url: $url, type: $type, thumbnailUrl: $thumbnailUrl, width: $width, height: $height, duration: $duration, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediaEntityImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.size, size) || other.size == size));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, url, type, thumbnailUrl, width, height, duration, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MediaEntityImplCopyWith<_$MediaEntityImpl> get copyWith =>
      __$$MediaEntityImplCopyWithImpl<_$MediaEntityImpl>(this, _$identity);
}

abstract class _MediaEntity extends MediaEntity {
  const factory _MediaEntity(
      {required final String url,
      required final String type,
      final String? thumbnailUrl,
      final int? width,
      final int? height,
      final int? duration,
      final int? size}) = _$MediaEntityImpl;
  const _MediaEntity._() : super._();

  @override

  /// URL pública del archivo (CDN o S3).
  String get url;
  @override

  /// Tipo de medio.
  /// Valores: 'image', 'video', 'audio'.
  String get type;
  @override

  /// URL de la miniatura (para videos).
  String? get thumbnailUrl;
  @override

  /// Ancho en píxeles (para imágenes/videos).
  int? get width;
  @override

  /// Alto en píxeles (para imágenes/videos).
  int? get height;
  @override

  /// Duración en segundos (para audio/video).
  int? get duration;
  @override

  /// Tamaño del archivo en bytes.
  int? get size;
  @override
  @JsonKey(ignore: true)
  _$$MediaEntityImplCopyWith<_$MediaEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
