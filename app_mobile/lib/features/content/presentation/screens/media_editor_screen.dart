import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Media editor screen with crop and filters
class MediaEditorScreen extends ConsumerStatefulWidget {
  final String imagePath;

  const MediaEditorScreen({
    super.key,
    required this.imagePath,
  });

  @override
  ConsumerState<MediaEditorScreen> createState() => _MediaEditorScreenState();
}

class _MediaEditorScreenState extends ConsumerState<MediaEditorScreen> {
  String _selectedFilter = 'none';
  double _brightness = 0.0;
  double _contrast = 1.0;
  double _saturation = 1.0;

  final List<Map<String, dynamic>> _filters = [
    {'name': 'None', 'value': 'none'},
    {'name': 'Grayscale', 'value': 'grayscale'},
    {'name': 'Sepia', 'value': 'sepia'},
    {'name': 'Vintage', 'value': 'vintage'},
    {'name': 'Cool', 'value': 'cool'},
    {'name': 'Warm', 'value': 'warm'},
  ];

  ColorFilter? _getColorFilter() {
    switch (_selectedFilter) {
      case 'grayscale':
        return const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      case 'sepia':
        return const ColorFilter.matrix([
          0.393, 0.769, 0.189, 0, 0,
          0.349, 0.686, 0.168, 0, 0,
          0.272, 0.534, 0.131, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      case 'vintage':
        return const ColorFilter.matrix([
          0.6, 0.3, 0.1, 0, 0,
          0.2, 0.7, 0.1, 0, 0,
          0.2, 0.3, 0.5, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      case 'cool':
        return const ColorFilter.matrix([
          0.8, 0, 0, 0, 0,
          0, 0.9, 0, 0, 0,
          0, 0, 1.2, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      case 'warm':
        return const ColorFilter.matrix([
          1.2, 0, 0, 0, 0,
          0, 1.0, 0, 0, 0,
          0, 0, 0.8, 0, 0,
          0, 0, 0, 1, 0,
        ]);
      default:
        return null;
    }
  }

  void _applyAndSave() {
    // TODO: Apply filters and save edited image
    // For now, just return the original path
    context.pop(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Edit Photo'),
        actions: [
          TextButton(
            onPressed: _applyAndSave,
            child: Text(
              'Done',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.nexusBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image preview
          Expanded(
            child: Center(
              child: ColorFiltered(
                colorFilter: _getColorFilter() ?? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.multiply,
                ),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Controls
          Container(
            padding: const EdgeInsets.all(AppDimensions.space16),
            decoration: const BoxDecoration(
              color: AppColors.darkMatter,
              border: Border(
                top: BorderSide(
                  color: AppColors.carbonFiber,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filters
                Text(
                  'Filters',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = _selectedFilter == filter['value'];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilter = filter['value'];
                          });
                        },
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.only(
                            right: AppDimensions.space8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.nexusBlue
                                  : AppColors.carbonFiber,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusSmall,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter,
                                color: isSelected
                                    ? AppColors.nexusBlue
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                filter['name'],
                                style: AppTypography.labelSmall.copyWith(
                                  color: isSelected
                                      ? AppColors.nexusBlue
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppDimensions.space16),

                // Adjustments
                Text(
                  'Adjustments',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.space8),

                // Brightness
                Row(
                  children: [
                    const Icon(
                      Icons.brightness_6,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: Slider(
                        value: _brightness,
                        min: -0.5,
                        max: 0.5,
                        activeColor: AppColors.nexusBlue,
                        onChanged: (value) {
                          setState(() {
                            _brightness = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Contrast
                Row(
                  children: [
                    const Icon(
                      Icons.contrast,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: Slider(
                        value: _contrast,
                        min: 0.5,
                        max: 1.5,
                        activeColor: AppColors.nexusBlue,
                        onChanged: (value) {
                          setState(() {
                            _contrast = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Saturation
                Row(
                  children: [
                    const Icon(
                      Icons.palette,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Expanded(
                      child: Slider(
                        value: _saturation,
                        min: 0.0,
                        max: 2.0,
                        activeColor: AppColors.nexusBlue,
                        onChanged: (value) {
                          setState(() {
                            _saturation = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
