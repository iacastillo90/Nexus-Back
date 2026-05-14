import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../app/theme/app_colors.dart';

/// Media viewer for fullscreen image viewing
class MediaViewer extends StatelessWidget {
  final List<String> mediaUrls;
  final int initialIndex;
  final String? heroTag;

  const MediaViewer({
    super.key,
    required this.mediaUrls,
    this.initialIndex = 0,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${initialIndex + 1} / ${mediaUrls.length}',
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: mediaUrls.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: heroTag != null && index == initialIndex
                  ? Hero(
                      tag: heroTag!,
                      child: CachedNetworkImage(
                        imageUrl: mediaUrls[index],
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.nexusBlue),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          color: AppColors.errorFlare,
                          size: 64,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: mediaUrls[index],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.nexusBlue),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline,
                        color: AppColors.errorFlare,
                        size: 64,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
