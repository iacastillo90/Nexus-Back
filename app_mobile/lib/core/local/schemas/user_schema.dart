import 'package:isar/isar.dart';

part 'user_schema.g.dart';

@collection
class UserSchema {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String userId;

  late String username;
  late String email;
  String? avatarUrl;
  String? bio;
  
  @Index()
  late DateTime lastSeen;
  
  bool isVerified = false;
  int karma = 0;
  
  // Sync metadata
  late DateTime lastUpdated;
  bool needsSync = false;
}
