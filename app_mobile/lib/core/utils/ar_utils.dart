import 'dart:math';
import 'package:vector_math/vector_math.dart' as vector;

class ARUtils {
  /// Calcula el ángulo (bearing) desde el usuario hasta el objetivo
  static double calculateBearing(double startLat, double startLng, double endLat, double endLng) {
    var startLatRad = vector.radians(startLat);
    var startLngRad = vector.radians(startLng);
    var endLatRad = vector.radians(endLat);
    var endLngRad = vector.radians(endLng);

    var dLng = endLngRad - startLngRad;
    var y = sin(dLng) * cos(endLatRad);
    var x = cos(startLatRad) * sin(endLatRad) - sin(startLatRad) * cos(endLatRad) * cos(dLng);
    
    return (vector.degrees(atan2(y, x)) + 360) % 360;
  }

  /// Determina si un objeto está en el campo de visión (FOV) de la cámara
  /// deviceHeading: Hacia dónde mira el teléfono (0-360)
  /// targetBearing: Dónde está el objeto (0-360)
  static bool isVisible(double deviceHeading, double targetBearing, double fov) {
    double diff = (targetBearing - deviceHeading + 180 + 360) % 360 - 180;
    return diff.abs() <= fov / 2;
  }
  
  /// Calcula la posición X en pantalla (-1 a 1)
  static double horizontalPosition(double deviceHeading, double targetBearing, double fov) {
     double diff = (targetBearing - deviceHeading + 180 + 360) % 360 - 180;
     return diff / (fov / 2); 
  }
}
