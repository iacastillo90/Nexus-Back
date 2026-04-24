import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nexus_mobile/app/theme/app_colors.dart';

class NexusNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const NexusNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppColors.shadowGrey,
        highlightColor: AppColors.carbonFiber,
        child: Container(
          width: width,
          height: height,
          color: AppColors.shadowGrey,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: AppColors.shadowGrey,
        child: const Icon(
          Icons.broken_image,
          color: AppColors.textSecondary,
        ),
      ),
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
