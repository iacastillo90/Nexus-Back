import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'search_result_entity.freezed.dart';

/// 🔍 **Tipos de Resultado de Búsqueda**
enum SearchResultType {
  user,
  post,
  tag,
}

/// 🔍 **Entidad de Resultado de Búsqueda**
///
/// Representa un ítem genérico devuelto por el motor de búsqueda.
/// Unifica usuarios, posts y hashtags en una estructura común.
///
/// **Responsabilidades:**
/// - Abstraer diferentes tipos de contenido para la lista de resultados.
/// - Proveer metadatos flexibles (followers, posts count) según el tipo.
///
/// **Referencias:**
/// - Backend: `src/controllers/search.controller.js`
@freezed
class SearchResultEntity with _$SearchResultEntity {
  const factory SearchResultEntity({
    /// ID del objeto encontrado (User ID, Post ID, Tag Name).
    required String id,

    /// Tipo de entidad (User, Post, Tag).
    required SearchResultType type,

    /// Título principal (Username, Post Title, Hashtag).
    required String title,

    /// Subtítulo descriptivo (Bio, Snippet, Count).
    required String subtitle,

    /// URL de imagen asociada (Avatar, Thumbnail).
    String? imageUrl,

    /// Datos extra específicos del tipo (followers, likes, etc.).
    Map<String, dynamic>? metadata,
  }) = _SearchResultEntity;

  const SearchResultEntity._();

  /// 🎭 **Icono del Tipo**
  IconData getIcon() {
    switch (type) {
      case SearchResultType.user:
        return Icons.person;
      case SearchResultType.post:
        return Icons.article;
      case SearchResultType.tag:
        return Icons.tag;
    }
  }

  /// 🎨 **Color del Tipo**
  Color getColor() {
    switch (type) {
      case SearchResultType.user:
        return const Color(0xFF00D9FF); // Cyan
      case SearchResultType.post:
        return const Color(0xFFB026FF); // Purple
      case SearchResultType.tag:
        return const Color(0xFF00FF85); // Green
    }
  }

  /// 🏷️ **Etiqueta del Tipo**
  String getTypeLabel() {
    switch (type) {
      case SearchResultType.user:
        return 'User';
      case SearchResultType.post:
        return 'Post';
      case SearchResultType.tag:
        return 'Tag';
    }
  }

  /// 👥 **Contador de Seguidores (Usuarios)**
  int? get followerCount {
    if (type == SearchResultType.user && metadata != null) {
      return metadata!['followerCount'] as int?;
    }
    return null;
  }

  /// 📝 **Contador de Posts (Tags)**
  int? get postCount {
    if (type == SearchResultType.tag && metadata != null) {
      return metadata!['postCount'] as int?;
    }
    return null;
  }

  /// ❤️ **Contador de Likes (Posts)**
  int? get likeCount {
    if (type == SearchResultType.post && metadata != null) {
      return metadata!['likeCount'] as int?;
    }
    return null;
  }
}
