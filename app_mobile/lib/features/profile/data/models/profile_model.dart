import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entity.dart';
import 'karma_model.dart';
import 'badge_model.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

/// Profile model for JSON serialization
@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String username,
    required String email,
    String? avatar,
    String? coverImage,
    String? bio,
    String? location,
    String? website,
    required int followersCount,
    required int followingCount,
    required int postsCount,
    required KarmaModel karma,
    List<BadgeModel>? badges,
    required DateTime createdAt,
    bool? isFollowing,
    bool? isPremium,
  }) = _ProfileModel;

  const ProfileModel._();

  /// From JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// To Entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      username: username,
      email: email,
      avatar: avatar,
      coverImage: coverImage,
      bio: bio,
      location: location,
      website: website,
      followersCount: followersCount,
      followingCount: followingCount,
      postsCount: postsCount,
      karma: karma.toEntity(),
      badges: badges?.map((b) => b.toEntity()).toList(),
      createdAt: createdAt,
      isFollowing: isFollowing,
      isPremium: isPremium,
    );
  }
}
