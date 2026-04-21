import 'package:isar/isar.dart';

part 'post_schema.g.dart';

@collection
class PostSchema {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String postId;

  late String authorId;
  late String authorName;
  String? authorAvatarUrl;
  
  late String content;
  List<String>? imageUrls;
  
  @Index()
  late DateTime createdAt;
  
  int likesCount = 0;
  int commentsCount = 0;
  bool isLiked = false;
  bool isBookmarked = false;
  
  // Sync metadata
  late DateTime lastUpdated;
  bool needsSync = false; // True if created/edited offline
}
