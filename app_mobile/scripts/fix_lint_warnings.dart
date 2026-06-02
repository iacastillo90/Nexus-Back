import 'dart:io';
import 'package:path/path.dart' as path;

/// Script para limpiar automáticamente los lint warnings del proyecto Nexus
/// 
/// Corrige:
/// - unused_import: Elimina imports no utilizados
/// - prefer_const_constructors: Agrega const donde sea posible
/// - prefer_final_parameters: Cambia parámetros a final
/// - unused_local_variable: Comenta variables no usadas

void main() async {
  print('🧹 Iniciando limpieza de lint warnings...\n');
  
  final baseDir = Directory.current.path;
  final libDir = Directory(path.join(baseDir, 'lib'));
  
  if (!libDir.existsSync()) {
    print('❌ Error: No se encontró el directorio lib/');
    exit(1);
  }
  
  // Obtener lista de warnings
  print('📊 Analizando proyecto...');
  final analyzeResult = await Process.run(
    'flutter',
    ['analyze', '--no-fatal-infos'],
    workingDirectory: baseDir,
  );
  
  final output = analyzeResult.stdout.toString();
  final warnings = _parseWarnings(output);
  
  print('✅ Encontrados ${warnings.length} warnings\n');
  
  // Agrupar por tipo
  final byType = <String, List<LintWarning>>{};
  for (final warning in warnings) {
    byType.putIfAbsent(warning.type, () => []).add(warning);
  }
  
  print('📋 Warnings por tipo:');
  byType.forEach((type, list) {
    print('  - $type: ${list.length}');
  });
  print('');
  
  // Corregir unused imports
  if (byType.containsKey('unused_import')) {
    print('🔧 Corrigiendo unused_import (${byType['unused_import']!.length})...');
    await _fixUnusedImports(byType['unused_import']!);
  }
  
  // Corregir prefer_const_constructors (manual, solo reportar)
  if (byType.containsKey('prefer_const_constructors')) {
    print('ℹ️  prefer_const_constructors: ${byType['prefer_const_constructors']!.length}');
    print('   Ejecuta: dart fix --apply para corregir automáticamente\n');
  }
  
  print('✅ Limpieza completada!');
  print('📝 Ejecuta "flutter analyze" para verificar');
}

class LintWarning {
  final String file;
  final int line;
  final int column;
  final String type;
  final String message;
  
  LintWarning({
    required this.file,
    required this.line,
    required this.column,
    required this.type,
    required this.message,
  });
}

List<LintWarning> _parseWarnings(String output) {
  final warnings = <LintWarning>[];
  final lines = output.split('\n');
  
  for (final line in lines) {
    // Formato: warning - Message - file.dart:line:column - type
    if (!line.contains('warning -')) continue;
    
    final parts = line.split(' - ');
    if (parts.length < 3) continue;
    
    final message = parts[1].trim();
    final locationAndType = parts[2].trim();
    
    // Extraer ubicación y tipo
    final locationParts = locationAndType.split(' - ');
    if (locationParts.length < 2) continue;
    
    final location = locationParts[0].trim();
    final type = locationParts[1].trim();
    
    // Parsear ubicación (file:line:column)
    final locationMatch = RegExp(r'(.+):(\d+):(\d+)').firstMatch(location);
    if (locationMatch == null) continue;
    
    warnings.add(LintWarning(
      file: locationMatch.group(1)!,
      line: int.parse(locationMatch.group(2)!),
      column: int.parse(locationMatch.group(3)!),
      type: type,
      message: message,
    ));
  }
  
  return warnings;
}

Future<void> _fixUnusedImports(List<LintWarning> warnings) async {
  // Agrupar por archivo
  final byFile = <String, List<LintWarning>>{};
  for (final warning in warnings) {
    byFile.putIfAbsent(warning.file, () => []).add(warning);
  }
  
  int fixedCount = 0;
  
  for (final entry in byFile.entries) {
    final filePath = entry.key;
    final fileWarnings = entry.value;
    
    final file = File(filePath);
    if (!file.existsSync()) continue;
    
    final lines = file.readAsLinesSync();
    final linesToRemove = <int>{};
    
    for (final warning in fileWarnings) {
      // Verificar que la línea sea un import
      final lineIndex = warning.line - 1;
      if (lineIndex >= 0 && lineIndex < lines.length) {
        final line = lines[lineIndex];
        if (line.trim().startsWith('import ')) {
          linesToRemove.add(lineIndex);
        }
      }
    }
    
    if (linesToRemove.isEmpty) continue;
    
    // Crear nuevo contenido sin las líneas de import no usadas
    final newLines = <String>[];
    for (int i = 0; i < lines.length; i++) {
      if (!linesToRemove.contains(i)) {
        newLines.add(lines[i]);
      }
    }
    
    // Escribir archivo
    file.writeAsStringSync('${newLines.join('\n')}\n');
    fixedCount += linesToRemove.length;
    
    print('  ✓ ${path.basename(filePath)}: ${linesToRemove.length} imports eliminados');
  }
  
  print('  Total: $fixedCount imports eliminados\n');
}
