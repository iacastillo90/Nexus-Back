import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_entity.dart';

part 'auth_response_entity.freezed.dart';

/// 🔐 **Respuesta de Autenticación**
///
/// Contenedor de datos devuelto tras un Login o Registro exitoso.
///
/// **Responsabilidades:**
/// - Transportar el Token JWT para sesiones autenticadas.
/// - Proveer los datos iniciales del usuario ([UserEntity]).
/// - Manejar tokens de refresco (para futura implementación).
///
/// **Referencias:**
/// - Backend: `src/controllers/auth.controller.js` (login/register response).
@freezed
class AuthResponseEntity with _$AuthResponseEntity {
  const factory AuthResponseEntity({
    /// Token JWT (JSON Web Token) válido.
    /// Debe enviarse en el header `Authorization: Bearer <token>` en requests protegidos.
    String? token,

    /// Entidad completa del usuario autenticado.
    required UserEntity user,

    /// Token de larga duración para renovar el acceso sin re-login.
    /// (Reservado para Fase 2).
    String? refreshToken,
  }) = _AuthResponseEntity;
}
