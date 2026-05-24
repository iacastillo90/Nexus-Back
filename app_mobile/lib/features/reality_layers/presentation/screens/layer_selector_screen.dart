import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/layer_providers.dart';
import '../widgets/layer_card.dart';
import '../../domain/entities/reality_layer_entity.dart';

/// Layer selector screen with grid of reality layers
class LayerSelectorScreen extends ConsumerWidget {
  const LayerSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layers = ref.watch(realityLayersProvider);
    final selectedLayer = ref.watch(selectedLayerProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.nexusBlue,
              AppColors.cyberPurple,
            ],
          ).createShader(bounds),
          child: Text(
            'Reality Layers',
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              context.push('/reality-map');
            },
            tooltip: 'Open Map',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Text(
              'Explore different layers of reality',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.space8),
            Text(
              'Each layer shows geo-located posts filtered by category',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            // All layers option
            LayerCard(
              layer: const RealityLayerEntity(
                id: 'all',
                name: 'All Layers',
                description: 'View posts from all reality layers',
                icon: '🌐',
                colorHex: '#00D9FF',
              ),
              isSelected: selectedLayer == null,
              onTap: () {
                ref.read(selectedLayerProvider.notifier).selectLayer(null);
                context.push('/reality-map');
              },
            ),

            const SizedBox(height: AppDimensions.space16),

            // Layer grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppDimensions.space12,
                  mainAxisSpacing: AppDimensions.space12,
                  childAspectRatio: 0.85,
                ),
                itemCount: layers.length,
                itemBuilder: (context, index) {
                  final layer = layers[index];

                  return LayerCard(
                    layer: layer,
                    isSelected: selectedLayer == layer.id,
                    onTap: () {
                      ref
                          .read(selectedLayerProvider.notifier)
                          .selectLayer(layer.id);
                      context.push('/reality-map');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
