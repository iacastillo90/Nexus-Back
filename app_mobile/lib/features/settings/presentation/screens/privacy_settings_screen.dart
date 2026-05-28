import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';

class PrivacySettingsScreen extends ConsumerStatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  ConsumerState<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends ConsumerState<PrivacySettingsScreen> {
  bool _isPrivateAccount = false;
  bool _allowTagging = true;
  bool _showActivityStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Privacy & Security'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('ACCOUNT PRIVACY'),
            NexusGlassContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildSwitchTile(
                    title: 'Private Account',
                    subtitle: 'Only followers can see your posts and dreams.',
                    value: _isPrivateAccount,
                    onChanged: (val) => setState(() => _isPrivateAccount = val),
                    icon: Icons.lock_outline,
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  _buildSwitchTile(
                    title: 'Activity Status',
                    subtitle: 'Show when you are active in the Nexus.',
                    value: _showActivityStatus,
                    onChanged: (val) => setState(() => _showActivityStatus = val),
                    icon: Icons.visibility_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            _buildSectionHeader('SECURITY'),
            NexusGlassContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildActionTile(
                    title: 'Change Password',
                    icon: Icons.key_outlined,
                    onTap: () {
                      // TODO: Navigate to Change Password Screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Change Password flow not implemented yet')),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  _buildActionTile(
                    title: 'Two-Factor Authentication',
                    icon: Icons.security_outlined,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Two-Factor Authentication setup coming soon'),
                          backgroundColor: AppColors.nexusBlue,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            _buildSectionHeader('INTERACTIONS'),
            NexusGlassContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _buildActionTile(
                    title: 'Blocked Users',
                    icon: Icons.block_outlined,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Blocked Users management coming soon'),
                          backgroundColor: AppColors.nexusBlue,
                        ),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Colors.white10),
                  _buildSwitchTile(
                    title: 'Allow Tagging',
                    subtitle: 'Allow others to tag you in posts.',
                    value: _allowTagging,
                    onChanged: (val) => setState(() => _allowTagging = val),
                    icon: Icons.alternate_email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: AppTypography.labelSmall.copyWith(
          color: AppColors.textTertiary,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
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
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.space16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.nexusBlue),
          const SizedBox(width: AppDimensions.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bodyMedium.copyWith(color: Colors.white),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
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

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.nexusBlue),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(color: Colors.white),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textTertiary),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimensions.space16, vertical: 4),
    );
  }
}
