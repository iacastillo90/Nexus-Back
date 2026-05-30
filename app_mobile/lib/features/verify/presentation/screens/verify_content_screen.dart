import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/verify_providers.dart';

/// Verify content screen with QR scanner
class VerifyContentScreen extends ConsumerStatefulWidget {
  const VerifyContentScreen({super.key});

  @override
  ConsumerState<VerifyContentScreen> createState() =>
      _VerifyContentScreenState();
}

class _VerifyContentScreenState extends ConsumerState<VerifyContentScreen> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verificationState = ref.watch(verificationResultProvider);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              AppColors.karmaVerified,
              AppColors.nexusBlue,
            ],
          ).createShader(bounds),
          child: Text(
            'Verify Content',
            style: AppTypography.headlineSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: verificationState.when(
        data: (result) {
          if (result == null) {
            return _buildScanner();
          } else {
            return _buildResult(result);
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.karmaVerified),
          ),
        ),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.errorFlare,
              ),
              const SizedBox(height: AppDimensions.space16),
              Text(
                'Verification failed',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppDimensions.space16),
              ElevatedButton(
                onPressed: () {
                  ref.read(verificationResultProvider.notifier).clear();
                },
                child: const Text('Scan Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanner() {
    return Stack(
      children: [
        // Camera view
        MobileScanner(
          controller: cameraController,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              if (barcode.rawValue != null) {
                ref
                    .read(verificationResultProvider.notifier)
                    .verifyByQR(barcode.rawValue!);
                break;
              }
            }
          },
        ),

        // Overlay
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.karmaVerified,
              width: 2,
            ),
          ),
          child: Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.karmaVerified,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        // Instructions
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(AppDimensions.space16),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: AppColors.darkMatter.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              border: Border.all(
                color: AppColors.karmaVerified,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.qr_code_scanner,
                  color: AppColors.karmaVerified,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'Scan QR Code',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Align the QR code within the frame',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResult(result) {
    final statusColor = result.getStatusColor();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.space16),
      child: Column(
        children: [
          // Status badge
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  statusColor.withValues(alpha: 0.3),
                  statusColor.withValues(alpha: 0.1),
                ],
              ),
              border: Border.all(
                color: statusColor,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: statusColor.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              result.getStatusIcon(),
              size: 64,
              color: statusColor,
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Status label
          Text(
            result.getStatusLabel(),
            style: AppTypography.headlineMedium.copyWith(
              color: statusColor,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: AppDimensions.space8),

          // Authenticity score
          Text(
            '${result.authenticityScore.toInt()}% Authentic',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: AppDimensions.space4),

          Text(
            result.getAuthenticityDescription(),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),

          const SizedBox(height: AppDimensions.space32),

          // Content DNA
          Container(
            padding: const EdgeInsets.all(AppDimensions.space16),
            decoration: BoxDecoration(
              color: AppColors.glassLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              border: Border.all(
                color: AppColors.nexusBlue.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.fingerprint,
                      color: AppColors.nexusBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Content DNA',
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.darkMatter,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    result.contentDNA,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.nexusBlue,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.space16),

          // Original info
          if (result.originalAuthor != null)
            Container(
              padding: const EdgeInsets.all(AppDimensions.space16),
              decoration: BoxDecoration(
                color: AppColors.glassLight,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: AppColors.carbonFiber,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Original Content',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Author', result.originalAuthor!),
                  if (result.originalSource != null)
                    _buildInfoRow('Source', result.originalSource!),
                  if (result.originalDate != null)
                    _buildInfoRow(
                      'Date',
                      '${result.originalDate!.day}/${result.originalDate!.month}/${result.originalDate!.year}',
                    ),
                ],
              ),
            ),

          const SizedBox(height: AppDimensions.space16),

          // Modifications
          if (result.modifications.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(AppDimensions.space16),
              decoration: BoxDecoration(
                color: AppColors.glassLight,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: AppColors.errorFlare.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.warning,
                        color: AppColors.errorFlare,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Detected Modifications',
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...result.modifications.map((mod) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 6,
                              color: AppColors.errorFlare,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              mod,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

          const SizedBox(height: AppDimensions.space32),

          // Scan again button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ref.read(verificationResultProvider.notifier).clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.nexusBlue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Scan Another'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
