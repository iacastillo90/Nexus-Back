# Architecture Analysis Script

Este script analiza toda la arquitectura del proyecto Nexus Flutter y genera un documento de texto comprehensivo con todo el código y análisis.

## Uso

```bash
# Desde la raíz del proyecto
dart scripts/analyze_architecture.dart
```

## Output

El script genera un archivo `NEXUS_FLUTTER_COMPLETE_ARCHITECTURE.txt` que incluye:

### 📦 Información del Proyecto
- Contenido de `pubspec.yaml`
- Dependencias principales y de desarrollo

### 📁 Código Organizado por Categorías
- **CONFIGURACIÓN RAÍZ:** pubspec.yaml, analysis_options.yaml
- **ENTRY POINT:** main.dart
- **THEME & DESIGN SYSTEM:** app_colors.dart, app_typography.dart, etc.
- **NAVIGATION:** app_router.dart
- **CORE/SHARED:** Utilidades compartidas
- **DOMAIN - ENTITIES:** Todas las entidades del dominio
- **DOMAIN - REPOSITORIES:** Interfaces de repositorios
- **DATA - MODELS:** Modelos con JSON serialization
- **DATA - DATASOURCES:** Fuentes de datos (API, local)
- **DATA - REPOSITORIES:** Implementaciones de repositorios
- **PRESENTATION - PROVIDERS:** Riverpod providers
- **PRESENTATION - SCREENS:** Pantallas de la app
- **PRESENTATION - WIDGETS:** Widgets reutilizables

### 📊 Para Cada Archivo
- Ruta relativa
- Tipo de archivo
- Líneas de código
- Tamaño en KB
- Dependencias importadas
- Clases/funciones exportadas
- **Código completo** (con syntax highlighting)
- Análisis de calidad (issues detectados)

### 🔎 Análisis Automático
- Total de archivos analizados
- Total de líneas de código
- Promedio de líneas por archivo
- Archivos sin documentación
- Archivos con `print()` (deberían usar logger)
- Archivos sin manejo de errores
- Archivos extensos (>300 líneas)
- **Recomendaciones técnicas**

## Características

### ✅ Detección Automática
- **Imports:** Extrae todos los `import` statements
- **Exports:** Detecta clases, funciones, enums exportados
- **Issues de Calidad:**
  - Uso de `print()` en lugar de logger
  - TODOs y FIXMEs pendientes
  - Falta de documentación (`///`)
  - DataSources sin try-catch
  - Archivos muy largos

### 🎯 Categorización Inteligente
El script categoriza automáticamente los archivos según su ubicación en la arquitectura feature-first:
- Domain layer (entities, repositories)
- Data layer (models, datasources, repository implementations)
- Presentation layer (providers, screens, widgets)

### 📈 Estadísticas Globales
- Conteo total de archivos y líneas
- Identificación de archivos problemáticos
- Recomendaciones priorizadas

## Exclusiones

El script excluye automáticamente:
- `node_modules`
- `.git`
- `build`
- `.dart_tool`
- Carpetas de plataforma (`android`, `ios`, `linux`, `macos`, `windows`, `web`)
- `test` (opcional, se puede incluir)

## Ejemplo de Output

```
================================================================================
ARCHIVO: lib/features/auth/domain/entities/user_entity.dart
TIPO: Entity (Domain)
LÍNEAS DE CÓDIGO: 45
TAMAÑO: 1.23 KB

DEPENDENCIAS IMPORTADAS (2):
  - package:freezed_annotation/freezed_annotation.dart
  - package:flutter/material.dart

CLASES/FUNCIONES EXPORTADAS (3):
  - class UserEntity
  - enum UserRole
  - function getUserDisplayName

────────────────────────────────────────────────────────────────────────────────
CÓDIGO COMPLETO:
────────────────────────────────────────────────────────────────────────────────
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String username,
    required String email,
    // ... resto del código
  }) = _UserEntity;
}
```

────────────────────────────────────────────────────────────────────────────────
ANÁLISIS DE CALIDAD:
📄 Sin documentación (falta ///)
================================================================================
```

## Notas

- El archivo generado puede ser muy grande (varios MB) dependiendo del tamaño del proyecto
- Se recomienda abrir con un editor que soporte archivos grandes (VS Code, Sublime Text)
- Útil para:
  - Documentación del proyecto
  - Code review
  - Onboarding de nuevos desarrolladores
  - Análisis de arquitectura
  - Compartir con LLMs para análisis
