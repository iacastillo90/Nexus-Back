import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../providers/auth_providers.dart';
import '../../../../core/widgets/widgets.dart';
import '../widgets/auth_header.dart';

/// Biometric setup screen for fingerprint/face ID
class BiometricSetupScreen extends ConsumerStatefulWidget {
  const BiometricSetupScreen({super.key});

  @override
  ConsumerState<BiometricSetupScreen> createState() =>
      _BiometricSetupScreenState();
}

class _BiometricSetupScreenState extends ConsumerState<BiometricSetupScreen> {
  bool _isChecking = false;
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    setState(() => _isChecking = true);

    final isAvailable =
        await ref.read(authControllerProvider.notifier).isBiometricAvailable();

    if (mounted) {
      setState(() {
        _isAvailable = isAvailable;
        _isChecking = false;
      });
    }
  }

  Future<void> _setupBiometric() async {
    final authenticated =
        await ref.read(authControllerProvider.notifier).verifyBiometric();

    if (!mounted) return;

    if (authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometric authentication enabled!'),
          backgroundColor: AppColors.successGlow,
        ),
      );

      // Navigate to home
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometric authentication failed'),
          backgroundColor: AppColors.errorFlare,
        ),
      );
    }
  }

  void _skip() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.voidBlack,
              AppColors.deepSpace,
              AppColors.darkMatter,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.space24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppDimensions.space64),

                // Header
                const AuthHeader(
                  title: 'Secure Your Account',
                  subtitle: 'Enable biometric authentication for quick access',
                ),

                const Spacer(),

                // Biometric icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: AppColors.purpleGlow,
                    color: AppColors.darkMatter,
                  ),
                  child: const Icon(
                    Icons.fingerprint,
                    size: 64,
                    color: AppColors.cyberPurple,
                  ),
                ),

                const SizedBox(height: AppDimensions.space48),

                // Status message
                if (_isChecking)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.nexusBlue),
                    ),
                  )
                else if (!_isAvailable)
                  Column(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.warningPulse,
                        size: 48,
                      ),
                      const SizedBox(height: AppDimensions.space16),
                      Text(
                        'Biometric authentication is not available on this device',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                else
                  Text(
                    'Use your fingerprint or face to unlock Nexus quickly and securely',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                const Spacer(),

                // Enable button
                if (_isAvailable && !_isChecking)
                  NexusButton(
                    onPressed: _setupBiometric,
                    text: 'Enable Biometric',
                  ),

                const SizedBox(height: AppDimensions.space16),

                // Skip button
                NexusButton(
                  onPressed: _skip,
                  type: NexusButtonType.ghost,
                  text: 'Skip for now',
                ),

                const SizedBox(height: AppDimensions.space32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
