import 'package:isar/isar.dart';

part 'request_queue_schema.g.dart';

@collection
class RequestQueueSchema {
  Id id = Isar.autoIncrement;

  late String method; // POST, PUT, DELETE
  late String url;
  String? body; // JSON string
  String? headers; // JSON string of Map<String, String>
  
  @Index()
  late DateTime createdAt;
  
  int retryCount = 0;
}
