import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// 👤 **Entidad de Usuario (User)**
///
/// Representa al usuario autenticado dentro del ecosistema Nexus.
/// Es el núcleo de la identidad digital y contiene datos de perfil, estado y permisos.
///
/// **Responsabilidades:**
/// - Almacenar información personal (nombre, email, username).
/// - Gestionar el estado de la cuenta (activo, verificado).
/// - Definir el nivel de acceso a Echo (IA) mediante `echoPlan`.
///
/// **Referencias:**
/// - Backend: `src/models/user.model.js` (Mongoose Schema).
/// - Base de Datos Local: `lib/core/local/schemas/user_schema.dart` (Isar).
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    /// ID único del usuario (UUID v4 generado por el Backend).
    required String id,

    /// Nombre de usuario único (@handle).
    required String username,

    /// Correo electrónico verificado.
    required String email,

    /// Nombre real (opcional).
    String? firstName,

    /// Apellido real (opcional).
    String? lastName,

    /// Indica si la cuenta está activa (no baneada/suspendida).
    required bool isActive,

    /// Indica si el usuario ha verificado su identidad (Blue Check).
    required bool isVerified,

    /// Indica si el asistente IA (Echo) está habilitado para este usuario.
    required bool echoEnabled,

    /// Plan de suscripción de Echo.
    /// Valores: 'free' (básico), 'premium' (avanzado), 'creator' (ilimitado).
    @Default('free') String echoPlan,

    /// Configuración del gemelo digital (Auto-Reply, Autonomy).
    Map<String, dynamic>? echoConfig,

    /// Fecha de creación de la cuenta.
    required DateTime createdAt,

    /// Fecha de última actualización del perfil.
    required DateTime updatedAt,
  }) = _UserEntity;

  const UserEntity._();

  /// 🏷️ **Obtener Nombre para Mostrar**
  ///
  /// Devuelve el nombre completo si está disponible, o el username como fallback.
  /// Útil para encabezados de perfil y tarjetas de feed.
  String get displayName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return username;
  }

  /// 🔤 **Obtener Iniciales**
  ///
  /// Genera las iniciales (ej: "JD" o "NE") para usar en Avatares por defecto.
  String get initials {
    if (firstName != null && lastName != null) {
      return '${firstName![0]}${lastName![0]}'.toUpperCase();
    }
    if (username.length >= 2) {
      return username.substring(0, 2).toUpperCase();
    }
    return username.substring(0, 1).toUpperCase();
  }

  /// 💎 **Es Premium**
  ///
  /// Retorna `true` si el usuario tiene un plan de pago (Premium o Creator).
  /// Habilita características avanzadas como subida de 4K, IA ilimitada, etc.
  bool get isPremium => echoPlan == 'premium' || echoPlan == 'creator';

  /// 🎨 **Es Creador**
  ///
  /// Retorna `true` si el usuario tiene el nivel más alto (Creator).
  /// Habilita herramientas de monetización y analíticas avanzadas.
  bool get isCreator => echoPlan == 'creator';
}
