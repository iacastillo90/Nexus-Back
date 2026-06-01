import 'dart:io';
import 'package:path/path.dart' as path;

// ============================================================================
// CONFIGURACIÓN
// ============================================================================

const String OUTPUT_FILE = 'NEXUS_FLUTTER_COMPLETE_ARCHITECTURE.txt';

// Directorio base del proyecto (raíz donde está pubspec.yaml)
final String BASE_DIR = Directory.current.path;

// Carpetas a EXCLUIR del análisis
const List<String> EXCLUDED_DIRS = [
  'node_modules',
  '.git',
  'build',
  '.dart_tool',
  '.idea',
  '.vscode',
  'android',
  'ios',
  'linux',
  'macos',
  'windows',
  'web',
  'test',
  '.flutter-plugins',
  '.flutter-plugins-dependencies',
];

// Extensiones de archivos a procesar
const List<String> VALID_EXTENSIONS = ['.dart', '.yaml', '.json'];

// ============================================================================
// FUNCIONES AUXILIARES
// ============================================================================

/// Determina si una ruta debe ser ignorada
bool shouldIgnore(String filePath) {
  return EXCLUDED_DIRS.any((dir) => filePath.contains('${Platform.pathSeparator}$dir${Platform.pathSeparator}'));
}

/// Obtiene el tipo de archivo basado en su ubicación
String getFileType(String filePath) {
  if (filePath.contains('entities')) return 'Entity (Domain)';
  if (filePath.contains('repositories') && filePath.contains('domain')) return 'Repository Interface (Domain)';
  if (filePath.contains('repositories') && filePath.contains('data')) return 'Repository Implementation (Data)';
  if (filePath.contains('models')) return 'Model (Data)';
  if (filePath.contains('datasources')) return 'DataSource (Data)';
  if (filePath.contains('providers')) return 'Provider (Presentation)';
  if (filePath.contains('screens')) return 'Screen (Presentation)';
  if (filePath.contains('widgets')) return 'Widget (Presentation)';
  if (filePath.contains('theme')) return 'Theme/Design System';
  if (filePath.contains('router')) return 'Navigation';
  if (filePath.contains('core')) return 'Core/Shared';
  if (filePath.endsWith('main.dart')) return 'Entry Point';
  if (filePath.endsWith('pubspec.yaml')) return 'Package Configuration';
  if (filePath.endsWith('analysis_options.yaml')) return 'Lint Configuration';
  return 'Other';
}

/// Extrae imports de un archivo Dart
List<String> extractImports(String code) {
  final importRegex = RegExp(r'''import\s+['"]([^'"]+)['"]''');
  final matches = importRegex.allMatches(code);
  return matches.map((m) => m.group(1)!).toList();
}

/// Extrae exports de un archivo Dart
List<String> extractExports(String code) {
  final exports = <String>[];
  
  // Classes
  final classRegex = RegExp(r'class\s+(\w+)');
  exports.addAll(classRegex.allMatches(code).map((m) => 'class ${m.group(1)}'));
  
  // Functions
  final functionRegex = RegExp(r'(?:Future<\w+>|void|String|int|bool|double)\s+(\w+)\s*\(');
  exports.addAll(functionRegex.allMatches(code).map((m) => 'function ${m.group(1)}'));
  
  // Enums
  final enumRegex = RegExp(r'enum\s+(\w+)');
  exports.addAll(enumRegex.allMatches(code).map((m) => 'enum ${m.group(1)}'));
  
  return exports.toSet().toList(); // Remove duplicates
}

/// Detecta issues en el código
List<String> detectIssues(String code, String filePath, String type) {
  final issues = <String>[];
  
  if (code.contains('print(')) {
    issues.add('⚠️ Contiene print() (debería usar logger o debugPrint)');
  }
  if (code.contains('TODO:') || code.contains('TODO ')) {
    issues.add('📝 Contiene TODOs pendientes');
  }
  if (code.contains('FIXME')) {
    issues.add('🔧 Contiene FIXMEs');
  }
  if (!code.contains('///') && type.contains('Domain') && !filePath.contains('test')) {
    issues.add('📄 Sin documentación (falta ///)');
  }
  if (type.contains('DataSource') && !code.contains('try') && !code.contains('catch')) {
    issues.add('⚠️ DataSource sin manejo de errores (try-catch)');
  }
  
  // Check for long files
  final lines = code.split('\n').length;
  if (lines > 300) {
    issues.add('🔴 Archivo muy largo (>300 líneas)');
  }
  
  return issues;
}

/// Procesa un archivo individual
Map<String, dynamic>? processFile(String filePath) {
  final fullPath = path.join(BASE_DIR, filePath);
  final relativePath = path.relative(fullPath, from: BASE_DIR);
  
  final file = File(fullPath);
  if (!file.existsSync()) return null;
  
  try {
    final stats = file.statSync();
    if (stats.type != FileSystemEntityType.file) return null;
    
    final code = file.readAsStringSync();
    final lines = code.split('\n').length;
    final type = getFileType(relativePath);
    final imports = extractImports(code);
    final exports = extractExports(code);
    final issues = detectIssues(code, relativePath, type);
    
    final buffer = StringBuffer();
    buffer.writeln('\n${'=' * 80}');
    buffer.writeln('ARCHIVO: $relativePath');
    buffer.writeln('TIPO: $type');
    buffer.writeln('LÍNEAS DE CÓDIGO: $lines');
    buffer.writeln('TAMAÑO: ${(stats.size / 1024).toStringAsFixed(2)} KB');
    
    if (imports.isNotEmpty) {
      buffer.writeln('\nDEPENDENCIAS IMPORTADAS (${imports.length}):');
      for (final imp in imports) {
        buffer.writeln('  - $imp');
      }
    }
    
    if (exports.isNotEmpty) {
      buffer.writeln('\nCLASES/FUNCIONES EXPORTADAS (${exports.length}):');
      for (final exp in exports.take(20)) { // Limit to 20
        buffer.writeln('  - $exp');
      }
      if (exports.length > 20) {
        buffer.writeln('  ... y ${exports.length - 20} más');
      }
    }
    
    buffer.writeln('\n${'─' * 80}');
    buffer.writeln('CÓDIGO COMPLETO:');
    buffer.writeln('─' * 80);
    buffer.writeln('```dart');
    buffer.writeln(code);
    buffer.writeln('```');
    
    if (issues.isNotEmpty) {
      buffer.writeln('\n${'─' * 80}');
      buffer.writeln('ANÁLISIS DE CALIDAD:');
      for (final issue in issues) {
        buffer.writeln(issue);
      }
    }
    
    buffer.writeln('=' * 80);
    
    return {
      'output': buffer.toString(),
      'stats': {
        'lines': lines,
        'imports': imports.length,
        'exports': exports.length,
        'issues': issues,
      }
    };
  } catch (e) {
    return {
      'output': '\n⚠️ ERROR AL PROCESAR: $relativePath\n   Razón: $e\n',
      'stats': {'lines': 0, 'imports': 0, 'exports': 0, 'issues': <String>[]},
    };
  }
}

/// Escanea recursivamente un directorio
List<String> scanDirectory(Directory dir, [String basePath = '']) {
  final files = <String>[];
  
  try {
    final entries = dir.listSync();
    
    for (final entry in entries) {
      final relativePath = path.join(basePath, path.basename(entry.path));
      
      if (shouldIgnore(entry.path)) continue;
      
      if (entry is Directory) {
        files.addAll(scanDirectory(entry, relativePath));
      } else if (entry is File) {
        final ext = path.extension(entry.path);
        if (VALID_EXTENSIONS.contains(ext)) {
          files.add(relativePath);
        }
      }
    }
  } catch (e) {
    print('Error escaneando directorio ${dir.path}: $e');
  }
  
  return files;
}

/// Categoriza archivos por tipo
Map<String, List<String>> categorizeFiles(List<String> files) {
  final categories = <String, List<String>>{
    'CONFIGURACIÓN RAÍZ': [],
    'ENTRY POINT': [],
    'THEME & DESIGN SYSTEM': [],
    'NAVIGATION': [],
    'CORE/SHARED': [],
    'DOMAIN - ENTITIES': [],
    'DOMAIN - REPOSITORIES': [],
    'DATA - MODELS': [],
    'DATA - DATASOURCES': [],
    'DATA - REPOSITORIES': [],
    'PRESENTATION - PROVIDERS': [],
    'PRESENTATION - SCREENS': [],
    'PRESENTATION - WIDGETS': [],
    'OTROS': [],
  };
  
  for (final file in files) {
    if (file == 'pubspec.yaml' || file == 'analysis_options.yaml') {
      categories['CONFIGURACIÓN RAÍZ']!.add(file);
    } else if (file.endsWith('main.dart')) {
      categories['ENTRY POINT']!.add(file);
    } else if (file.contains('theme${Platform.pathSeparator}')) {
      categories['THEME & DESIGN SYSTEM']!.add(file);
    } else if (file.contains('router${Platform.pathSeparator}')) {
      categories['NAVIGATION']!.add(file);
    } else if (file.contains('core${Platform.pathSeparator}')) {
      categories['CORE/SHARED']!.add(file);
    } else if (file.contains('domain${Platform.pathSeparator}entities')) {
      categories['DOMAIN - ENTITIES']!.add(file);
    } else if (file.contains('domain${Platform.pathSeparator}repositories')) {
      categories['DOMAIN - REPOSITORIES']!.add(file);
    } else if (file.contains('data${Platform.pathSeparator}models')) {
      categories['DATA - MODELS']!.add(file);
    } else if (file.contains('data${Platform.pathSeparator}datasources')) {
      categories['DATA - DATASOURCES']!.add(file);
    } else if (file.contains('data${Platform.pathSeparator}repositories')) {
      categories['DATA - REPOSITORIES']!.add(file);
    } else if (file.contains('presentation${Platform.pathSeparator}providers')) {
      categories['PRESENTATION - PROVIDERS']!.add(file);
    } else if (file.contains('presentation${Platform.pathSeparator}screens')) {
      categories['PRESENTATION - SCREENS']!.add(file);
    } else if (file.contains('presentation${Platform.pathSeparator}widgets')) {
      categories['PRESENTATION - WIDGETS']!.add(file);
    } else {
      categories['OTROS']!.add(file);
    }
  }
  
  return categories;
}

// ============================================================================
// EJECUCIÓN PRINCIPAL
// ============================================================================

void main() async {
  print('🚀 Iniciando análisis de arquitectura Nexus Flutter...\n');
  print('📁 Directorio base: $BASE_DIR\n');
  
  // Escanear todos los archivos
  print('📂 Escaneando estructura de directorios...');
  final allFiles = scanDirectory(Directory(BASE_DIR));
  print('✅ Encontrados ${allFiles.length} archivos para analizar\n');
  
  // Categorizar archivos
  final categorizedFiles = categorizeFiles(allFiles);
  
  // Generar encabezado del documento
  final buffer = StringBuffer();
  buffer.writeln('=' * 80);
  buffer.writeln('NEXUS FLUTTER - CÓDIGO COMPLETO Y ARQUITECTURA');
  buffer.writeln('Fecha de Generación: ${DateTime.now().toIso8601String()}');
  buffer.writeln('=' * 80);
  buffer.writeln();
  
  buffer.writeln('📦 INFORMACIÓN DEL PROYECTO');
  buffer.writeln('=' * 80);
  
  // Leer pubspec.yaml si existe
  final pubspecPath = path.join(BASE_DIR, 'pubspec.yaml');
  final pubspecFile = File(pubspecPath);
  if (pubspecFile.existsSync()) {
    final pubspecContent = pubspecFile.readAsStringSync();
    buffer.writeln('PUBSPEC.YAML:');
    buffer.writeln(pubspecContent);
  }
  
  buffer.writeln('\n');
  
  // Estadísticas globales
  final globalStats = {
    'totalFiles': 0,
    'totalLines': 0,
    'filesWithoutDocs': <String>[],
    'filesWithPrint': <String>[],
    'filesWithoutErrorHandling': <String>[],
    'largeFiles': <Map<String, dynamic>>[],
  };
  
  // Procesar archivos por categoría
  for (final entry in categorizedFiles.entries) {
    final category = entry.key;
    final files = entry.value;
    
    if (files.isEmpty) continue;
    
    buffer.writeln('\n${'=' * 80}');
    buffer.writeln('CATEGORÍA: $category (${files.length} archivos)');
    buffer.writeln('=' * 80);
    
    print('\n📁 Procesando categoría: $category');
    
    for (final file in files) {
      print('   ├─ $file');
      final result = processFile(file);
      
      if (result != null) {
        buffer.write(result['output']);
        globalStats['totalFiles'] = (globalStats['totalFiles'] as int) + 1;
        globalStats['totalLines'] = (globalStats['totalLines'] as int) + (result['stats']['lines'] as int);
        
        final issues = result['stats']['issues'] as List<String>;
        if (issues.any((i) => i.contains('Sin documentación'))) {
          (globalStats['filesWithoutDocs'] as List<String>).add(file);
        }
        if (issues.any((i) => i.contains('print()'))) {
          (globalStats['filesWithPrint'] as List<String>).add(file);
        }
        if (issues.any((i) => i.contains('sin manejo de errores'))) {
          (globalStats['filesWithoutErrorHandling'] as List<String>).add(file);
        }
        if ((result['stats']['lines'] as int) > 300) {
          (globalStats['largeFiles'] as List<Map<String, dynamic>>).add({
            'file': file,
            'lines': result['stats']['lines'],
          });
        }
      }
    }
  }
  
  // Análisis automático final
  buffer.writeln('\n\n${'=' * 80}');
  buffer.writeln('🔎 ANÁLISIS AUTOMÁTICO - RESUMEN EJECUTIVO');
  buffer.writeln('=' * 80);
  buffer.writeln();
  
  buffer.writeln('📊 ESTADÍSTICAS GENERALES:');
  buffer.writeln('  - Total de archivos analizados: ${globalStats['totalFiles']}');
  buffer.writeln('  - Total de líneas de código: ${globalStats['totalLines']}');
  final avgLines = (globalStats['totalFiles'] as int) > 0 
      ? ((globalStats['totalLines'] as int) / (globalStats['totalFiles'] as int)).round()
      : 0;
  buffer.writeln('  - Promedio de líneas por archivo: $avgLines');
  buffer.writeln('  - Archivos sin documentación: ${(globalStats['filesWithoutDocs'] as List).length}');
  buffer.writeln('  - Archivos con print(): ${(globalStats['filesWithPrint'] as List).length}');
  buffer.writeln('  - Archivos sin manejo de errores: ${(globalStats['filesWithoutErrorHandling'] as List).length}');
  buffer.writeln('  - Archivos extensos (>300 líneas): ${(globalStats['largeFiles'] as List).length}');
  
  if ((globalStats['filesWithoutDocs'] as List).isNotEmpty) {
    buffer.writeln('\n📄 ARCHIVOS SIN DOCUMENTACIÓN:');
    final filesWithoutDocs = globalStats['filesWithoutDocs'] as List<String>;
    for (final f in filesWithoutDocs.take(10)) {
      buffer.writeln('  - $f');
    }
    if (filesWithoutDocs.length > 10) {
      buffer.writeln('  ... y ${filesWithoutDocs.length - 10} más');
    }
  }
  
  if ((globalStats['filesWithPrint'] as List).isNotEmpty) {
    buffer.writeln('\n⚠️ ARCHIVOS CON PRINT() (MIGRAR A LOGGER):');
    for (final f in globalStats['filesWithPrint'] as List<String>) {
      buffer.writeln('  - $f');
    }
  }
  
  if ((globalStats['largeFiles'] as List).isNotEmpty) {
    buffer.writeln('\n📏 ARCHIVOS EXTENSOS (CONSIDERAR REFACTORIZACIÓN):');
    final largeFiles = globalStats['largeFiles'] as List<Map<String, dynamic>>;
    largeFiles.sort((a, b) => (b['lines'] as int).compareTo(a['lines'] as int));
    for (final item in largeFiles.take(5)) {
      buffer.writeln('  - ${item['file']} (${item['lines']} líneas)');
    }
  }
  
  buffer.writeln('\n🏗️ RECOMENDACIONES TÉCNICAS:');
  buffer.writeln('  1. Agregar documentación /// a ${(globalStats['filesWithoutDocs'] as List).length} archivos');
  buffer.writeln('  2. Reemplazar print() por debugPrint o logger en ${(globalStats['filesWithPrint'] as List).length} archivos');
  buffer.writeln('  3. Implementar manejo de errores en ${(globalStats['filesWithoutErrorHandling'] as List).length} datasources');
  buffer.writeln('  4. Refactorizar ${(globalStats['largeFiles'] as List).length} archivos extensos');
  buffer.writeln('  5. Implementar tests unitarios y de widgets');
  
  // Escribir archivo final
  final outputFile = File(OUTPUT_FILE);
  outputFile.writeAsStringSync(buffer.toString());
  
  print('\n${'=' * 80}');
  print('✅ ANÁLISIS COMPLETADO');
  print('=' * 80);
  print('📄 Archivo generado: $OUTPUT_FILE');
  print('📊 Archivos analizados: ${globalStats['totalFiles']}');
  print('📏 Total de líneas: ${globalStats['totalLines']}');
  final fileSize = outputFile.statSync().size / 1024 / 1024;
  print('📦 Tamaño del reporte: ${fileSize.toStringAsFixed(2)} MB');
  print('=' * 80);
}
