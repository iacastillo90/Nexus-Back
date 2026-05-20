// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileEntity {
  /// ID del usuario.
  String get id => throw _privateConstructorUsedError;

  /// Handle único (@username).
  String get username => throw _privateConstructorUsedError;

  /// Email (puede estar ofuscado si no es el propio usuario).
  String get email => throw _privateConstructorUsedError;

  /// URL del avatar.
  String? get avatar => throw _privateConstructorUsedError;

  /// URL de la imagen de portada.
  String? get coverImage => throw _privateConstructorUsedError;

  /// Biografía corta.
  String? get bio => throw _privateConstructorUsedError;

  /// Ubicación (Ciudad, País).
  String? get location => throw _privateConstructorUsedError;

  /// Enlace externo.
  String? get website => throw _privateConstructorUsedError;

  /// Cantidad de seguidores.
  int get followersCount => throw _privateConstructorUsedError;

  /// Cantidad de seguidos.
  int get followingCount => throw _privateConstructorUsedError;

  /// Cantidad de publicaciones.
  int get postsCount => throw _privateConstructorUsedError;

  /// Puntuación detallada de Karma.
  KarmaEntity get karma => throw _privateConstructorUsedError;

  /// Lista de insignias ganadas.
  List<BadgeEntity>? get badges => throw _privateConstructorUsedError;

  /// Fecha de registro.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Indica si el usuario actual sigue a este perfil.
  bool? get isFollowing => throw _privateConstructorUsedError;

  /// Indica si es un usuario Premium.
  bool? get isPremium => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfileEntityCopyWith<ProfileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEntityCopyWith<$Res> {
  factory $ProfileEntityCopyWith(
          ProfileEntity value, $Res Function(ProfileEntity) then) =
      _$ProfileEntityCopyWithImpl<$Res, ProfileEntity>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? avatar,
      String? coverImage,
      String? bio,
      String? location,
      String? website,
      int followersCount,
      int followingCount,
      int postsCount,
      KarmaEntity karma,
      List<BadgeEntity>? badges,
      DateTime createdAt,
      bool? isFollowing,
      bool? isPremium});

  $KarmaEntityCopyWith<$Res> get karma;
}

/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res, $Val extends ProfileEntity>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._value, this._then);

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
    Object? avatar = freezed,
    Object? coverImage = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? followersCount = null,
    Object? followingCount = null,
    Object? postsCount = null,
    Object? karma = null,
    Object? badges = freezed,
    Object? createdAt = null,
    Object? isFollowing = freezed,
    Object? isPremium = freezed,
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
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      postsCount: null == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as int,
      karma: null == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as KarmaEntity,
      badges: freezed == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<BadgeEntity>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFollowing: freezed == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPremium: freezed == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $KarmaEntityCopyWith<$Res> get karma {
    return $KarmaEntityCopyWith<$Res>(_value.karma, (value) {
      return _then(_value.copyWith(karma: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileEntityImplCopyWith<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  factory _$$ProfileEntityImplCopyWith(
          _$ProfileEntityImpl value, $Res Function(_$ProfileEntityImpl) then) =
      __$$ProfileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String? avatar,
      String? coverImage,
      String? bio,
      String? location,
      String? website,
      int followersCount,
      int followingCount,
      int postsCount,
      KarmaEntity karma,
      List<BadgeEntity>? badges,
      DateTime createdAt,
      bool? isFollowing,
      bool? isPremium});

  @override
  $KarmaEntityCopyWith<$Res> get karma;
}

/// @nodoc
class __$$ProfileEntityImplCopyWithImpl<$Res>
    extends _$ProfileEntityCopyWithImpl<$Res, _$ProfileEntityImpl>
    implements _$$ProfileEntityImplCopyWith<$Res> {
  __$$ProfileEntityImplCopyWithImpl(
      _$ProfileEntityImpl _value, $Res Function(_$ProfileEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? avatar = freezed,
    Object? coverImage = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? followersCount = null,
    Object? followingCount = null,
    Object? postsCount = null,
    Object? karma = null,
    Object? badges = freezed,
    Object? createdAt = null,
    Object? isFollowing = freezed,
    Object? isPremium = freezed,
  }) {
    return _then(_$ProfileEntityImpl(
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
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      postsCount: null == postsCount
          ? _value.postsCount
          : postsCount // ignore: cast_nullable_to_non_nullable
              as int,
      karma: null == karma
          ? _value.karma
          : karma // ignore: cast_nullable_to_non_nullable
              as KarmaEntity,
      badges: freezed == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<BadgeEntity>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFollowing: freezed == isFollowing
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool?,
      isPremium: freezed == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$ProfileEntityImpl extends _ProfileEntity {
  const _$ProfileEntityImpl(
      {required this.id,
      required this.username,
      required this.email,
      this.avatar,
      this.coverImage,
      this.bio,
      this.location,
      this.website,
      required this.followersCount,
      required this.followingCount,
      required this.postsCount,
      required this.karma,
      final List<BadgeEntity>? badges,
      required this.createdAt,
      this.isFollowing,
      this.isPremium})
      : _badges = badges,
        super._();

  /// ID del usuario.
  @override
  final String id;

  /// Handle único (@username).
  @override
  final String username;

  /// Email (puede estar ofuscado si no es el propio usuario).
  @override
  final String email;

  /// URL del avatar.
  @override
  final String? avatar;

  /// URL de la imagen de portada.
  @override
  final String? coverImage;

  /// Biografía corta.
  @override
  final String? bio;

  /// Ubicación (Ciudad, País).
  @override
  final String? location;

  /// Enlace externo.
  @override
  final String? website;

  /// Cantidad de seguidores.
  @override
  final int followersCount;

  /// Cantidad de seguidos.
  @override
  final int followingCount;

  /// Cantidad de publicaciones.
  @override
  final int postsCount;

  /// Puntuación detallada de Karma.
  @override
  final KarmaEntity karma;

  /// Lista de insignias ganadas.
  final List<BadgeEntity>? _badges;

  /// Lista de insignias ganadas.
  @override
  List<BadgeEntity>? get badges {
    final value = _badges;
    if (value == null) return null;
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Fecha de registro.
  @override
  final DateTime createdAt;

  /// Indica si el usuario actual sigue a este perfil.
  @override
  final bool? isFollowing;

  /// Indica si es un usuario Premium.
  @override
  final bool? isPremium;

  @override
  String toString() {
    return 'ProfileEntity(id: $id, username: $username, email: $email, avatar: $avatar, coverImage: $coverImage, bio: $bio, location: $location, website: $website, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, karma: $karma, badges: $badges, createdAt: $createdAt, isFollowing: $isFollowing, isPremium: $isPremium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.karma, karma) || other.karma == karma) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      email,
      avatar,
      coverImage,
      bio,
      location,
      website,
      followersCount,
      followingCount,
      postsCount,
      karma,
      const DeepCollectionEquality().hash(_badges),
      createdAt,
      isFollowing,
      isPremium);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      __$$ProfileEntityImplCopyWithImpl<_$ProfileEntityImpl>(this, _$identity);
}

abstract class _ProfileEntity extends ProfileEntity {
  const factory _ProfileEntity(
      {required final String id,
      required final String username,
      required final String email,
      final String? avatar,
      final String? coverImage,
      final String? bio,
      final String? location,
      final String? website,
      required final int followersCount,
      required final int followingCount,
      required final int postsCount,
      required final KarmaEntity karma,
      final List<BadgeEntity>? badges,
      required final DateTime createdAt,
      final bool? isFollowing,
      final bool? isPremium}) = _$ProfileEntityImpl;
  const _ProfileEntity._() : super._();

  @override

  /// ID del usuario.
  String get id;
  @override

  /// Handle único (@username).
  String get username;
  @override

  /// Email (puede estar ofuscado si no es el propio usuario).
  String get email;
  @override

  /// URL del avatar.
  String? get avatar;
  @override

  /// URL de la imagen de portada.
  String? get coverImage;
  @override

  /// Biografía corta.
  String? get bio;
  @override

  /// Ubicación (Ciudad, País).
  String? get location;
  @override

  /// Enlace externo.
  String? get website;
  @override

  /// Cantidad de seguidores.
  int get followersCount;
  @override

  /// Cantidad de seguidos.
  int get followingCount;
  @override

  /// Cantidad de publicaciones.
  int get postsCount;
  @override

  /// Puntuación detallada de Karma.
  KarmaEntity get karma;
  @override

  /// Lista de insignias ganadas.
  List<BadgeEntity>? get badges;
  @override

  /// Fecha de registro.
  DateTime get createdAt;
  @override

  /// Indica si el usuario actual sigue a este perfil.
  bool? get isFollowing;
  @override

  /// Indica si es un usuario Premium.
  bool? get isPremium;
  @override
  @JsonKey(ignore: true)
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
