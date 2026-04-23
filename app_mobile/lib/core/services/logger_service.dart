import 'package:logger/logger.dart';

/// 📝 **Servicio de Logging Global**
///
/// Envoltura estática sobre el paquete `logger`.
/// Provee una salida de consola formateada, colorida y estructurada.
///
/// **Responsabilidades:**
/// - Estandarizar los logs de la aplicación.
/// - Diferenciar niveles de severidad (Debug, Info, Warning, Error).
/// - Ocultar logs en producción (si se configura).
class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // No mostrar stacktrace por defecto
      errorMethodCount: 8, // Mostrar stacktrace completo en errores
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// 🐛 **Debug Log**
  ///
  /// Para información detallada útil durante el desarrollo.
  static void d(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// ℹ️ **Info Log**
  ///
  /// Para eventos generales del flujo de la app (ej: "Usuario logueado").
  static void i(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// ⚠️ **Warning Log**
  ///
  /// Para situaciones inesperadas que no detienen la app (ej: "Token expirado").
  static void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// 🚨 **Error Log**
  ///
  /// Para fallos críticos y excepciones (ej: "Fallo de conexión a DB").
  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// 🔍 **Verbose Log**
  ///
  /// Para trazas de muy bajo nivel.
  static void v(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }
}
