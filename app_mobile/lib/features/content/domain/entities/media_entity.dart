import 'package:freezed_annotation/freezed_annotation.dart';

part 'media_entity.freezed.dart';

/// 🎬 **Entidad Multimedia**
///
/// Representa un archivo subido (imagen, video, audio) con sus metadatos.
/// Se utiliza en Posts, Mensajes y Perfiles.
///
/// **Responsabilidades:**
/// - Abstraer la URL y el tipo de archivo.
/// - Proveer metadatos técnicos (dimensiones, duración, tamaño).
/// - Facilitar la renderización en la UI (thumbnails).
@freezed
class MediaEntity with _$MediaEntity {
  const factory MediaEntity({
    /// URL pública del archivo (CDN o S3).
    required String url,

    /// Tipo de medio.
    /// Valores: 'image', 'video', 'audio'.
    required String type,

    /// URL de la miniatura (para videos).
    String? thumbnailUrl,

    /// Ancho en píxeles (para imágenes/videos).
    int? width,

    /// Alto en píxeles (para imágenes/videos).
    int? height,

    /// Duración en segundos (para audio/video).
    int? duration,

    /// Tamaño del archivo en bytes.
    int? size,
  }) = _MediaEntity;

  const MediaEntity._();

  /// 🖼️ **Es Imagen**
  bool get isImage => type == 'image';

  /// 🎥 **Es Video**
  bool get isVideo => type == 'video';

  /// 🎵 **Es Audio**
  bool get isAudio => type == 'audio';
}
