import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_response_entity.dart';
import 'user_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

/// 🔐 **Modelo de Respuesta de Autenticación**
///
/// DTO para parsear la respuesta JSON de login/registro.
/// Contiene el token JWT y los datos del usuario.
///
/// **Responsabilidades:**
/// - Serializar/Deserializar JSON.
/// - Mapear a [AuthResponseEntity] para el dominio.
///
/// **Referencias:**
/// - Backend: `src/controllers/auth.controller.js`
@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    /// Token JWT de acceso (Bearer).
    String? token,

    /// Datos del usuario autenticado.
    required UserModel user,

    /// Token de refresco (opcional).
    String? refreshToken,
  }) = _AuthResponseModel;

  const AuthResponseModel._();

  /// 📥 **Desde JSON**
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  /// 🔄 **A Entidad de Dominio**
  AuthResponseEntity toEntity() {
    return AuthResponseEntity(
      token: token,
      user: user.toEntity(),
      refreshToken: refreshToken,
    );
  }
}
