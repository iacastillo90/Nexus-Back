import 'package:isar/isar.dart';

part 'message_schema.g.dart';

@collection
class MessageSchema {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String messageId;

  @Index()
  late String conversationId;

  late String senderId;
  late String content;
  String type = 'text'; // text, image, audio
  
  @Index()
  late DateTime timestamp;
  
  bool isRead = false;
  bool isSent = true; // False if pending (offline)
  
  // Sync metadata
  bool needsSync = false;
}
