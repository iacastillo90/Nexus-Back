// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  int get followersCount => throw _privateConstructorUsedError;
  int get followingCount => throw _privateConstructorUsedError;
  int get postsCount => throw _privateConstructorUsedError;
  KarmaModel get karma => throw _privateConstructorUsedError;
  List<BadgeModel>? get badges => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool? get isFollowing => throw _privateConstructorUsedError;
  bool? get isPremium => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
          ProfileModel value, $Res Function(ProfileModel) then) =
      _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
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
      KarmaModel karma,
      List<BadgeModel>? badges,
      DateTime createdAt,
      bool? isFollowing,
      bool? isPremium});

  $KarmaModelCopyWith<$Res> get karma;
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

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
              as KarmaModel,
      badges: freezed == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<BadgeModel>?,
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
  $KarmaModelCopyWith<$Res> get karma {
    return $KarmaModelCopyWith<$Res>(_value.karma, (value) {
      return _then(_value.copyWith(karma: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
          _$ProfileModelImpl value, $Res Function(_$ProfileModelImpl) then) =
      __$$ProfileModelImplCopyWithImpl<$Res>;
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
      KarmaModel karma,
      List<BadgeModel>? badges,
      DateTime createdAt,
      bool? isFollowing,
      bool? isPremium});

  @override
  $KarmaModelCopyWith<$Res> get karma;
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
      _$ProfileModelImpl _value, $Res Function(_$ProfileModelImpl) _then)
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
    return _then(_$ProfileModelImpl(
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
              as KarmaModel,
      badges: freezed == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<BadgeModel>?,
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
@JsonSerializable()
class _$ProfileModelImpl extends _ProfileModel {
  const _$ProfileModelImpl(
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
      final List<BadgeModel>? badges,
      required this.createdAt,
      this.isFollowing,
      this.isPremium})
      : _badges = badges,
        super._();

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String? avatar;
  @override
  final String? coverImage;
  @override
  final String? bio;
  @override
  final String? location;
  @override
  final String? website;
  @override
  final int followersCount;
  @override
  final int followingCount;
  @override
  final int postsCount;
  @override
  final KarmaModel karma;
  final List<BadgeModel>? _badges;
  @override
  List<BadgeModel>? get badges {
    final value = _badges;
    if (value == null) return null;
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final bool? isFollowing;
  @override
  final bool? isPremium;

  @override
  String toString() {
    return 'ProfileModel(id: $id, username: $username, email: $email, avatar: $avatar, coverImage: $coverImage, bio: $bio, location: $location, website: $website, followersCount: $followersCount, followingCount: $followingCount, postsCount: $postsCount, karma: $karma, badges: $badges, createdAt: $createdAt, isFollowing: $isFollowing, isPremium: $isPremium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
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

  @JsonKey(ignore: true)
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
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(
      this,
    );
  }
}

abstract class _ProfileModel extends ProfileModel {
  const factory _ProfileModel(
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
      required final KarmaModel karma,
      final List<BadgeModel>? badges,
      required final DateTime createdAt,
      final bool? isFollowing,
      final bool? isPremium}) = _$ProfileModelImpl;
  const _ProfileModel._() : super._();

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String? get avatar;
  @override
  String? get coverImage;
  @override
  String? get bio;
  @override
  String? get location;
  @override
  String? get website;
  @override
  int get followersCount;
  @override
  int get followingCount;
  @override
  int get postsCount;
  @override
  KarmaModel get karma;
  @override
  List<BadgeModel>? get badges;
  @override
  DateTime get createdAt;
  @override
  bool? get isFollowing;
  @override
  bool? get isPremium;
  @override
  @JsonKey(ignore: true)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
