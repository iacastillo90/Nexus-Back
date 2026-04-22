/// Service for handling deep links
class DeepLinkService {
  static const String _baseUrl = 'https://nexus.app';

  /// Generate link for a post
  static String getPostLink(String postId) {
    return '$_baseUrl/post/$postId';
  }

  /// Generate link for a user profile
  static String getProfileLink(String userId) {
    return '$_baseUrl/profile/$userId';
  }

  /// Generate link for a chat with mentor
  static String getChatLink(String mentorId) {
    return '$_baseUrl/chat/$mentorId';
  }

  /// Parse path from url
  static String? getPathFromUrl(String url) {
    if (url.startsWith(_baseUrl)) {
      return url.substring(_baseUrl.length);
    }
    return null;
  }
}
