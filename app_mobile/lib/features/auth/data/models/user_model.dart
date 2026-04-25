import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// 👤 **Modelo de Usuario (DTO)**
///
/// Representación JSON del usuario en la API.
///
/// **Responsabilidades:**
/// - Serialización JSON <-> Objeto.
/// - Transformación a [UserEntity] (Dominio).
///
/// **Referencias:**
/// - Backend: `src/models/user.model.js`
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    /// ID único (UUID).
    required String id,

    /// Nombre de usuario único.
    required String username,

    /// Correo electrónico.
    required String email,

    /// Nombre real (opcional).
    String? firstName,

    /// Apellido real (opcional).
    String? lastName,

    /// Si la cuenta está activa.
    required bool isActive,

    /// Si el email/identidad está verificada.
    required bool isVerified,

    /// Si tiene activado el asistente Echo.
    required bool echoEnabled,

    /// Plan de suscripción ('free', 'premium').
    @Default('free') String echoPlan,

    /// Configuración del gemelo digital.
    Map<String, dynamic>? echoConfig,

    /// Fecha de creación.
    required DateTime createdAt,

    /// Fecha de última actualización.
    required DateTime updatedAt,
  }) = _UserModel;

  const UserModel._();

  /// 📥 **Desde JSON**
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// 🔄 **A Entidad de Dominio**
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      isActive: isActive,
      isVerified: isVerified,
      echoEnabled: echoEnabled,
      echoPlan: echoPlan,
      echoConfig: echoConfig,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// 🔄 **Desde Entidad de Dominio**
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      isActive: entity.isActive,
      isVerified: entity.isVerified,
      echoEnabled: entity.echoEnabled,
      echoPlan: entity.echoPlan,
      echoConfig: entity.echoConfig,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
