import '../../domain/entities/reality_layer_entity.dart';

/// Layer data source with hardcoded reality layers
class LayerDataSource {
  /// Get all reality layers
  List<RealityLayerEntity> getLayers() {
    return [
      const RealityLayerEntity(
        id: 'tech',
        name: 'Tech',
        description: 'Technology, innovation, and digital frontier',
        icon: '🔧',
        colorHex: '#00D9FF', // Cyan
      ),
      const RealityLayerEntity(
        id: 'art',
        name: 'Art',
        description: 'Creative expression and digital art',
        icon: '🎨',
        colorHex: '#FF006E', // Pink
      ),
      const RealityLayerEntity(
        id: 'science',
        name: 'Science',
        description: 'Scientific discoveries and research',
        icon: '🧬',
        colorHex: '#B026FF', // Purple
      ),
      const RealityLayerEntity(
        id: 'underground',
        name: 'Underground',
        description: 'Hidden knowledge and alternative perspectives',
        icon: '🔐',
        colorHex: '#00FF85', // Green
      ),
      const RealityLayerEntity(
        id: 'social',
        name: 'Social',
        description: 'Community, events, and connections',
        icon: '👥',
        colorHex: '#FF9500', // Orange
      ),
    ];
  }

  /// Get layer by ID
  RealityLayerEntity? getLayerById(String id) {
    try {
      return getLayers().firstWhere((layer) => layer.id == id);
    } catch (e) {
      return null;
    }
  }
}
