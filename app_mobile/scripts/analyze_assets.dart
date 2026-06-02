import 'dart:io';

void main() {
  final assetsDir = Directory('assets');
  final libDir = Directory('lib');

  if (!assetsDir.existsSync()) {
    print('Assets directory not found');
    return;
  }

  final assetFiles = assetsDir
      .listSync(recursive: true)
      .whereType<File>()
      .map((e) => e.path.replaceAll('\\', '/'))
      .toList();

  final sourceFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((e) => e.path.endsWith('.dart'))
      .toList();

  print('Found ${assetFiles.length} assets');
  print('Scanning ${sourceFiles.length} dart files...');

  final unusedAssets = <String>[];

  for (final asset in assetFiles) {
    // Get relative path from project root
    // e.g., assets/images/logo.png
    final relativePath = asset.substring(asset.indexOf('assets/'));
    bool isUsed = false;

    for (final source in sourceFiles) {
      final content = source.readAsStringSync();
      if (content.contains(relativePath)) {
        isUsed = true;
        break;
      }
    }

    if (!isUsed) {
      unusedAssets.add(relativePath);
    }
  }

  if (unusedAssets.isEmpty) {
    print('All assets are used! Great job.');
  } else {
    print('Found ${unusedAssets.length} unused assets:');
    for (final asset in unusedAssets) {
      print('- $asset');
    }
  }
}
