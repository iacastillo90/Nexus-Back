const fs = require('fs');
const path = require('path');
const logger = require('../src/utils/logger');

// ============================================================================
// CONFIGURACIÓN
// ============================================================================

const OUTPUT_FILE = 'NEXUS_BACKEND_COMPLETE_ARCHITECTURE.txt';

// 🔥 CAMBIO CRÍTICO: Ajusta esta ruta a donde está tu proyecto
// Si el script está en /scripts/, entonces BASE_DIR debe apuntar a la raíz
const BASE_DIR = path.join(__dirname, '..'); // Un nivel arriba desde /scripts/

// Carpetas a EXCLUIR del análisis
const EXCLUDED_DIRS = [
    'node_modules',
    '.git',
    'dist',
    'build',
    'coverage',
    '.vscode',
    '.idea'
];

// Extensiones de archivos a procesar
const VALID_EXTENSIONS = ['.js', '.json', '.ts'];

// ============================================================================
// FUNCIONES AUXILIARES
// ============================================================================

/**
 * Determina si una ruta debe ser ignorada
 */
function shouldIgnore(filePath) {
    return EXCLUDED_DIRS.some(dir => filePath.includes(`${path.sep}${dir}${path.sep}`));
}

/**
 * Obtiene el tipo de archivo basado en su ubicación
 */
function getFileType(filePath) {
    if (filePath.includes('controller')) return 'Controller';
    if (filePath.includes('service')) return 'Service';
    if (filePath.includes('repository')) return 'Repository';
    if (filePath.includes('middleware')) return 'Middleware';
    if (filePath.includes('model')) return 'Model';
    if (filePath.includes('route')) return 'Route';
    if (filePath.includes('config')) return 'Config';
    if (filePath.includes('util')) return 'Utility';
    if (filePath.includes('test')) return 'Test';
    if (filePath.includes('script')) return 'Script';
    if (filePath.includes('socket')) return 'Socket Handler';
    if (filePath.endsWith('server.js')) return 'Entry Point';
    if (filePath.endsWith('app.js')) return 'Application Setup';
    if (filePath.endsWith('package.json')) return 'Package Configuration';
    return 'Other';
}

/**
 * Extrae imports/requires de un archivo
 */
function extractImports(code) {
    const requireRegex = /require\s*\(\s*['"]([^'"]+)['"]\s*\)/g;
    const importRegex = /import\s+.*\s+from\s+['"]([^'"]+)['"]/g;
    const imports = new Set();

    let match;
    while ((match = requireRegex.exec(code)) !== null) {
        imports.add(match[1]);
    }
    while ((match = importRegex.exec(code)) !== null) {
        imports.add(match[1]);
    }

    return Array.from(imports);
}

/**
 * Extrae exports de un archivo
 */
function extractExports(code) {
    const exports = new Set();

    // module.exports = { foo, bar }
    const objectExportMatch = code.match(/module\.exports\s*=\s*\{([^}]+)\}/s);
    if (objectExportMatch) {
        const items = objectExportMatch[1]
            .split(',')
            .map(e => e.trim().split(':')[0].trim())
            .filter(e => e && !e.includes('//'));
        items.forEach(item => exports.add(item));
    }

    // module.exports = Something
    const singleExportMatch = code.match(/module\.exports\s*=\s*(\w+)/);
    if (singleExportMatch && !objectExportMatch) {
        exports.add(singleExportMatch[1]);
    }

    // exports.foo = ...
    const namedExportRegex = /exports\.(\w+)\s*=/g;
    let match;
    while ((match = namedExportRegex.exec(code)) !== null) {
        exports.add(match[1]);
    }

    // export { foo, bar }
    const esExportMatch = code.match(/export\s+\{([^}]+)\}/);
    if (esExportMatch) {
        const items = esExportMatch[1].split(',').map(e => e.trim());
        items.forEach(item => exports.add(item));
    }

    // export function/class/const
    const esNamedExportRegex = /export\s+(function|class|const)\s+(\w+)/g;
    while ((match = esNamedExportRegex.exec(code)) !== null) {
        exports.add(match[2]);
    }

    return Array.from(exports);
}

/**
 * Detecta issues en el código
 */
function detectIssues(code, filePath, type) {
    const issues = [];

    // Split strings to avoid self-detection
    if (code.includes('console' + '.log') || code.includes('console' + '.error')) {
        issues.push('⚠️ Contiene console' + '.log/error (debería usar logger)');
    }
    if (code.includes('TODO:') || code.includes('TODO ')) {
        issues.push('📝 Contiene TODOs pendientes');
    }
    if (code.includes('FIXME')) {
        issues.push('🔧 Contiene FIXMEs');
    }
    if (!code.includes('/**') && type !== 'Config' && type !== 'Other' && !filePath.includes('test')) {
        issues.push('📄 Sin JSDoc (falta documentación)');
    }
    if (type === 'Service' && !code.includes('try') && !code.includes('catch')) {
        issues.push('⚠️ Servicio sin manejo de errores (try-catch)');
    }
    if (code.match(/function\s+\w+[^{]*{[^}]{500,}}/s)) {
        issues.push('🔴 Contiene funciones muy largas (>50 líneas)');
    }

    return issues;
}

/**
 * Procesa un archivo individual
 */
function processFile(filePath) {
    const fullPath = path.join(BASE_DIR, filePath);
    const relativePath = path.relative(BASE_DIR, fullPath);

    if (!fs.existsSync(fullPath)) {
        return null; // Saltar archivos que no existen
    }

    try {
        const stats = fs.statSync(fullPath);
        if (!stats.isFile()) return null;

        const code = fs.readFileSync(fullPath, 'utf-8');
        const lines = code.split('\n').length;
        const type = getFileType(relativePath);
        const imports = extractImports(code);
        const exports = extractExports(code);
        const issues = detectIssues(code, relativePath, type);

        let output = '\n' + '='.repeat(80) + '\n';
        output += `ARCHIVO: ${relativePath}\n`;
        output += `TIPO: ${type}\n`;
        output += `LÍNEAS DE CÓDIGO: ${lines}\n`;
        output += `TAMAÑO: ${(stats.size / 1024).toFixed(2)} KB\n`;

        if (imports.length > 0) {
            output += `\nDEPENDENCIAS IMPORTADAS (${imports.length}):\n`;
            imports.forEach(imp => output += `  - ${imp}\n`);
        }

        if (exports.length > 0) {
            output += `\nFUNCIONES/CLASES EXPORTADAS (${exports.length}):\n`;
            exports.forEach(exp => output += `  - ${exp}\n`);
        }

        output += `\n${'─'.repeat(80)}\n`;
        output += `CÓDIGO COMPLETO:\n`;
        output += `${'─'.repeat(80)}\n`;
        output += '```javascript\n';
        output += code;
        output += '\n```\n';

        if (issues.length > 0) {
            output += `\n${'─'.repeat(80)}\n`;
            output += `ANÁLISIS DE CALIDAD:\n`;
            issues.forEach(issue => output += `${issue}\n`);
        }

        output += '='.repeat(80) + '\n';

        return { output, stats: { lines, imports: imports.length, exports: exports.length, issues } };
    } catch (error) {
        return {
            output: `\n⚠️ ERROR AL PROCESAR: ${relativePath}\n   Razón: ${error.message}\n`,
            stats: { lines: 0, imports: 0, exports: 0, issues: [] }
        };
    }
}

/**
 * Escanea recursivamente un directorio
 */
function scanDirectory(dir, basePath = '') {
    const files = [];

    try {
        const entries = fs.readdirSync(dir, { withFileTypes: true });

        for (const entry of entries) {
            const fullPath = path.join(dir, entry.name);
            const relativePath = path.join(basePath, entry.name);

            if (shouldIgnore(fullPath)) continue;

            if (entry.isDirectory()) {
                files.push(...scanDirectory(fullPath, relativePath));
            } else if (entry.isFile()) {
                const ext = path.extname(entry.name);
                if (VALID_EXTENSIONS.includes(ext)) {
                    files.push(relativePath);
                }
            }
        }
    } catch (error) {
        logger.error(`Error escaneando directorio ${dir}: ${error.message}`);
    }

    return files;
}

/**
 * Categoriza archivos por tipo
 */
function categorizeFiles(files) {
    const categories = {
        'CONFIGURACIÓN RAÍZ': [],
        'ENTRY POINTS': [],
        'CONFIGURACIÓN': [],
        'MODELOS': [],
        'REPOSITORIOS': [],
        'SERVICIOS': [],
        'CONTROLADORES': [],
        'MIDDLEWARE': [],
        'RUTAS': [],
        'SOCKET HANDLERS': [],
        'UTILIDADES': [],
        'TESTS': [],
        'SCRIPTS': [],
        'OTROS': []
    };

    for (const file of files) {
        if (file === 'package.json' || file === 'package-lock.json' || file.endsWith('.config.js')) {
            categories['CONFIGURACIÓN RAÍZ'].push(file);
        } else if (file === 'server.js' || file.endsWith('app.js')) {
            categories['ENTRY POINTS'].push(file);
        } else if (file.includes('config' + path.sep)) {
            categories['CONFIGURACIÓN'].push(file);
        } else if (file.includes('models' + path.sep)) {
            categories['MODELOS'].push(file);
        } else if (file.includes('repositories' + path.sep) || file.includes('repository')) {
            categories['REPOSITORIOS'].push(file);
        } else if (file.includes('services' + path.sep) || file.includes('service')) {
            categories['SERVICIOS'].push(file);
        } else if (file.includes('controllers' + path.sep) || file.includes('controller')) {
            categories['CONTROLADORES'].push(file);
        } else if (file.includes('middleware' + path.sep)) {
            categories['MIDDLEWARE'].push(file);
        } else if (file.includes('routes' + path.sep) || file.includes('route')) {
            categories['RUTAS'].push(file);
        } else if (file.includes('socket' + path.sep)) {
            categories['SOCKET HANDLERS'].push(file);
        } else if (file.includes('utils' + path.sep) || file.includes('util')) {
            categories['UTILIDADES'].push(file);
        } else if (file.includes('test' + path.sep) || file.includes('spec.')) {
            categories['TESTS'].push(file);
        } else if (file.includes('scripts' + path.sep)) {
            categories['SCRIPTS'].push(file);
        } else {
            categories['OTROS'].push(file);
        }
    }

    return categories;
}

// ============================================================================
// EJECUCIÓN PRINCIPAL
// ============================================================================

logger.info('🚀 Iniciando análisis de arquitectura Nexus Backend...\n');
logger.info(`📁 Directorio base: ${BASE_DIR}\n`);

// Escanear todos los archivos
logger.info('📂 Escaneando estructura de directorios...');
const allFiles = scanDirectory(BASE_DIR);
logger.info(`✅ Encontrados ${allFiles.length} archivos para analizar\n`);

// Categorizar archivos
const categorizedFiles = categorizeFiles(allFiles);

// Generar encabezado del documento
let fullDoc = '='.repeat(80) + '\n';
fullDoc += 'NEXUS BACKEND - CÓDIGO COMPLETO Y ARQUITECTURA\n';
fullDoc += `Fecha de Generación: ${new Date().toISOString()}\n`;
fullDoc += '='.repeat(80) + '\n\n';

fullDoc += '📦 INFORMACIÓN DEL PROYECTO\n';
fullDoc += '='.repeat(80) + '\n';

// Leer package.json si existe
const packageJsonPath = path.join(BASE_DIR, 'package.json');
if (fs.existsSync(packageJsonPath)) {
    const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf-8'));
    fullDoc += `Nombre: ${packageJson.name || 'N/A'}\n`;
    fullDoc += `Versión: ${packageJson.version || 'N/A'}\n`;
    fullDoc += `Descripción: ${packageJson.description || 'N/A'}\n`;
    fullDoc += `Node Version: ${packageJson.engines?.node || 'Compatible con ES6+'}\n`;

    fullDoc += `\n📋 DEPENDENCIAS PRINCIPALES:\n`;
    if (packageJson.dependencies) {
        Object.entries(packageJson.dependencies).forEach(([pkg, version]) => {
            fullDoc += `  - ${pkg}: ${version}\n`;
        });
    }

    fullDoc += `\n📋 DEPENDENCIAS DE DESARROLLO:\n`;
    if (packageJson.devDependencies) {
        Object.entries(packageJson.devDependencies).forEach(([pkg, version]) => {
            fullDoc += `  - ${pkg}: ${version}\n`;
        });
    }
}

fullDoc += '\n\n';

// Estadísticas globales
const globalStats = {
    totalFiles: 0,
    totalLines: 0,
    filesWithoutJSDoc: [],
    filesWithConsoleLog: [],
    filesWithoutErrorHandling: [],
    largeFiles: []
};

// Procesar archivos por categoría
for (const [category, files] of Object.entries(categorizedFiles)) {
    if (files.length === 0) continue;

    fullDoc += '\n' + '='.repeat(80) + '\n';
    fullDoc += `CATEGORÍA: ${category} (${files.length} archivos)\n`;
    fullDoc += '='.repeat(80) + '\n';

    logger.info(`\n📁 Procesando categoría: ${category}`);

    for (const file of files) {
        logger.info(`   ├─ ${file}`);
        const result = processFile(file);

        if (result) {
            fullDoc += result.output;
            globalStats.totalFiles++;
            globalStats.totalLines += result.stats.lines;

            if (result.stats.issues.some(i => i.includes('Sin JSDoc'))) {
                globalStats.filesWithoutJSDoc.push(file);
            }
            if (result.stats.issues.some(i => i.includes('console.log'))) {
                globalStats.filesWithConsoleLog.push(file);
            }
            if (result.stats.issues.some(i => i.includes('sin manejo de errores'))) {
                globalStats.filesWithoutErrorHandling.push(file);
            }
            if (result.stats.lines > 200) {
                globalStats.largeFiles.push({ file, lines: result.stats.lines });
            }
        }
    }
}

// Análisis automático final
fullDoc += '\n\n' + '='.repeat(80) + '\n';
fullDoc += '🔎 ANÁLISIS AUTOMÁTICO - RESUMEN EJECUTIVO\n';
fullDoc += '='.repeat(80) + '\n\n';

fullDoc += `📊 ESTADÍSTICAS GENERALES:\n`;
fullDoc += `  - Total de archivos analizados: ${globalStats.totalFiles}\n`;
fullDoc += `  - Total de líneas de código: ${globalStats.totalLines.toLocaleString()}\n`;
fullDoc += `  - Promedio de líneas por archivo: ${Math.round(globalStats.totalLines / globalStats.totalFiles)}\n`;
fullDoc += `  - Archivos sin JSDoc: ${globalStats.filesWithoutJSDoc.length}\n`;
fullDoc += `  - Archivos con console.log: ${globalStats.filesWithConsoleLog.length}\n`;
fullDoc += `  - Archivos sin manejo de errores: ${globalStats.filesWithoutErrorHandling.length}\n`;
fullDoc += `  - Archivos extensos (>200 líneas): ${globalStats.largeFiles.length}\n`;

if (globalStats.filesWithoutJSDoc.length > 0) {
    fullDoc += `\n📄 ARCHIVOS SIN DOCUMENTACIÓN JSDoc:\n`;
    globalStats.filesWithoutJSDoc.slice(0, 10).forEach(f => fullDoc += `  - ${f}\n`);
    if (globalStats.filesWithoutJSDoc.length > 10) {
        fullDoc += `  ... y ${globalStats.filesWithoutJSDoc.length - 10} más\n`;
    }
}

if (globalStats.filesWithConsoleLog.length > 0) {
    fullDoc += `\n⚠️ ARCHIVOS CON CONSOLE.LOG (MIGRAR A LOGGER):\n`;
    globalStats.filesWithConsoleLog.forEach(f => fullDoc += `  - ${f}\n`);
}

if (globalStats.largeFiles.length > 0) {
    fullDoc += `\n📏 ARCHIVOS EXTENSOS (CONSIDERAR REFACTORIZACIÓN):\n`;
    globalStats.largeFiles
        .sort((a, b) => b.lines - a.lines)
        .slice(0, 5)
        .forEach(({ file, lines }) => fullDoc += `  - ${file} (${lines} líneas)\n`);
}

fullDoc += `\n🏗️ RECOMENDACIONES TÉCNICAS:\n`;
fullDoc += `  1. Agregar JSDoc a ${globalStats.filesWithoutJSDoc.length} archivos sin documentación\n`;
fullDoc += `  2. Reemplazar console.log por Winston logger en ${globalStats.filesWithConsoleLog.length} archivos\n`;
fullDoc += `  3. Implementar manejo de errores en ${globalStats.filesWithoutErrorHandling.length} servicios\n`;
fullDoc += `  4. Refactorizar ${globalStats.largeFiles.length} archivos extensos (aplicar Single Responsibility)\n`;
fullDoc += `  5. Implementar tests unitarios (cobertura actual: estimada <30%)\n`;

// Escribir archivo final
fs.writeFileSync(OUTPUT_FILE, fullDoc, 'utf-8');

logger.info(`\n${'='.repeat(80)}`);
logger.info(`✅ ANÁLISIS COMPLETADO`);
logger.info(`${'='.repeat(80)}`);
logger.info(`📄 Archivo generado: ${OUTPUT_FILE}`);
logger.info(`📊 Archivos analizados: ${globalStats.totalFiles}`);
logger.info(`📏 Total de líneas: ${globalStats.totalLines.toLocaleString()}`);
logger.info(`📦 Tamaño del reporte: ${(fs.statSync(OUTPUT_FILE).size / 1024 / 1024).toFixed(2)} MB`);
logger.info(`${'='.repeat(80)}\n`);
