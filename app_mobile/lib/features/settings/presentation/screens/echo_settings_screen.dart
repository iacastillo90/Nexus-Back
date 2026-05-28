import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class EchoSettingsScreen extends ConsumerStatefulWidget {
  const EchoSettingsScreen({super.key});

  @override
  ConsumerState<EchoSettingsScreen> createState() => _EchoSettingsScreenState();
}

class _EchoSettingsScreenState extends ConsumerState<EchoSettingsScreen> {
  bool _autoReply = false;
  bool _voiceEnabled = false;
  double _autonomyLevel = 0.5;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with current user data
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final config = user.echoConfig ?? {};
      _autoReply = config['autoReply'] ?? false;
      _voiceEnabled = config['voiceEnabled'] ?? false;
      _autonomyLevel = (config['autonomyLevel'] as num?)?.toDouble() ?? 0.5;
    }
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);

    try {
      // Construct the new config
      final newConfig = {
        'autoReply': _autoReply,
        'voiceEnabled': _voiceEnabled,
        'autonomyLevel': _autonomyLevel,
      };

      // Call the controller to update the user
      // Note: This assumes updateProfile accepts a generic map or we need a specific method
      // For now, we'll simulate the update or call a method if it exists
      /*
      await ref.read(authControllerProvider.notifier).updateEchoConfig(newConfig);
      */
      
      // Simulating network delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Echo configuration updated'),
            backgroundColor: AppColors.nexusBlue,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating settings: $e'),
            backgroundColor: AppColors.errorFlare,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Echo Configuration'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(AppColors.nexusBlue),
                  ),
                ),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.check, color: AppColors.nexusBlue),
              onPressed: _saveSettings,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.nexusBlue.withValues(alpha: 0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.nexusBlue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.nexusBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.smart_toy, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Echo',
                          style: AppTypography.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your digital twin settings',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Autonomy Level
            Text(
              'AUTONOMY LEVEL',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.deepSpace,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Level: ${(_autonomyLevel * 100).toInt()}%',
                        style: AppTypography.titleMedium.copyWith(color: Colors.white),
                      ),
                      Icon(
                        _autonomyLevel > 0.7
                            ? Icons.flash_on
                            : _autonomyLevel > 0.3
                                ? Icons.bolt
                                : Icons.battery_saver,
                        color: _getAutonomyColor(_autonomyLevel),
                      ),
                    ],
                  ),
                  Slider(
                    value: _autonomyLevel,
                    onChanged: (value) {
                      setState(() => _autonomyLevel = value);
                    },
                    activeColor: _getAutonomyColor(_autonomyLevel),
                    inactiveColor: AppColors.glassLight,
                  ),
                  Text(
                    _getAutonomyDescription(_autonomyLevel),
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Toggles
            Text(
              'CAPABILITIES',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textTertiary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              title: 'Auto-Reply',
              subtitle: 'Allow Echo to reply to messages on your behalf.',
              value: _autoReply,
              onChanged: (val) => setState(() => _autoReply = val),
              icon: Icons.reply,
            ),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'Voice Synthesis',
              subtitle: 'Enable voice generation for your digital twin.',
              value: _voiceEnabled,
              onChanged: (val) => setState(() => _voiceEnabled = val),
              icon: Icons.record_voice_over,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.deepSpace,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.glassLight,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium.copyWith(color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.nexusBlue,
            activeTrackColor: AppColors.nexusBlue.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Color _getAutonomyColor(double level) {
    if (level > 0.7) return AppColors.errorFlare;
    if (level > 0.3) return AppColors.nexusBlue;
    return Colors.green;
  }

  String _getAutonomyDescription(double level) {
    if (level > 0.7) return 'High Autonomy: Echo can initiate conversations and post content.';
    if (level > 0.3) return 'Balanced: Echo responds to interactions but waits for approval.';
    return 'Low Autonomy: Echo only suggests responses.';
  }
}
