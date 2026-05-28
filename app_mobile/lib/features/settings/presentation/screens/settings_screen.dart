import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Section
          _buildSectionHeader('ACCOUNT'),
          _buildSettingsTile(
            context,
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () => context.push('/profile/edit'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.security,
            title: 'Privacy & Security',
            onTap: () => context.push('/profile/settings/privacy'),
          ),
          
          const SizedBox(height: 24),

          // AI & Nexus Section
          _buildSectionHeader('NEXUS INTELLIGENCE'),
          _buildSettingsTile(
            context,
            icon: Icons.smart_toy,
            title: 'Echo Configuration',
            subtitle: 'Manage your digital twin',
            iconColor: AppColors.nexusBlue,
            onTap: () => context.push('/profile/settings/echo'),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.layers,
            title: 'Reality Layers',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reality Layers settings coming soon'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
            }, // TODO: Implement Reality Settings
          ),

          const SizedBox(height: 24),

          // App Section
          _buildSectionHeader('APP'),
          _buildSettingsTile(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification settings coming soon'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
            }, // TODO: Implement Notifications Settings
          ),
          _buildSettingsTile(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Help center coming soon'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
            }, // TODO: Implement Help
          ),

          const SizedBox(height: 48),

          // Logout
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorFlare.withValues(alpha: 0.1),
                foregroundColor: AppColors.errorFlare,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.errorFlare),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ),
          
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Nexus v1.0.0 (Beta)',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
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

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.deepSpace,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? Colors.white).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: AppTypography.bodyMedium.copyWith(color: Colors.white),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
              )
            : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textTertiary),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
