import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

class DigitalCertificateScreen extends StatelessWidget {
  final String contentDNA;
  final String authorUsername;
  final String timestamp;

  const DigitalCertificateScreen({
    required this.contentDNA,
    required this.authorUsername,
    required this.timestamp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Content DNA'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.nexusBlue),
            onPressed: () {
              Share.share(
                'Verifying content authenticity on Nexus.\nDNA: $contentDNA\nAuthor: @$authorUsername',
                subject: 'Nexus Content DNA Verification',
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Certificate Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.nexusBlue.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.verified, color: AppColors.nexusBlue, size: 32),
                        Text(
                          'NEXUS VERIFIED',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.voidBlack,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // QR Code
                    QrImageView(
                      data: contentDNA,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.voidBlack,
                    ),
                    const SizedBox(height: 24),

                    // Hash Display
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.glassLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.voidBlack.withValues(alpha: 0.1)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'DNA HASH',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contentDNA,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.voidBlack,
                              fontFamily: 'Courier', // Monospace for hash
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Metadata
                    _buildMetadataRow('Author', '@$authorUsername'),
                    _buildMetadataRow('Timestamp', timestamp),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'This certificate guarantees the authenticity and origin of the content within the Nexus network.',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
          ),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.voidBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
