import '../../../../core/local/schemas/post_schema.dart';
import '../../domain/entities/post_entity.dart';
import '../models/post_model.dart';

class PostMapper {
  static PostSchema toSchema(PostModel model) {
    return PostSchema()
      ..postId = model.id
      ..authorId = model.userId
      ..authorName = model.username ?? 'Unknown'
      ..authorAvatarUrl = model.userAvatar
      ..content = model.content
      ..imageUrls = model.mediaUrls
      ..createdAt = model.createdAt
      ..likesCount = model.likesCount
      ..commentsCount = model.commentsCount
      ..isLiked = model.isLiked
      ..isBookmarked = model.isBookmarked
      ..lastUpdated = DateTime.now()
      ..needsSync = false;
  }

  static PostEntity fromSchema(PostSchema schema) {
    return PostEntity(
      id: schema.postId,
      userId: schema.authorId,
      username: schema.authorName,
      userAvatar: schema.authorAvatarUrl,
      content: schema.content,
      mediaUrls: schema.imageUrls,
      mediaType: null, // Schema doesn't store this yet, default to null or infer
      likesCount: schema.likesCount,
      commentsCount: schema.commentsCount,
      sharesCount: 0, // Schema missing shares
      isLiked: schema.isLiked,
      isBookmarked: schema.isBookmarked,
      contentDNA: null,
      realityLayer: null,
      metadata: null,
      createdAt: schema.createdAt,
      updatedAt: schema.lastUpdated,
    );
  }
}
