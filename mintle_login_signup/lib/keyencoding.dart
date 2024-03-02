import 'package:uuid/uuid.dart';

String generateKey(String userId) {
  String uuid = Uuid().v4(); // Generate UUID
  return '$uuid' + '_' + userId;
}

String getUserIdFromKey(String key) {
  return key
      .split('_')
      .last; // Split key by '_' and get the last part (User ID)
}
