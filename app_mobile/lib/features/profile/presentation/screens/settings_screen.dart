import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

/// Settings screen
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _darkMode = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _privateProfile = false;
  bool _showOnlineStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.space16),
        children: [
          // Appearance
          const _SectionHeader(title: 'Appearance'),
          const SizedBox(height: AppDimensions.space8),
          _SettingsTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            trailing: Switch(
              value: _darkMode,
              activeThumbColor: AppColors.nexusBlue,
              onChanged: (value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Notifications
          const _SectionHeader(title: 'Notifications'),
          const SizedBox(height: AppDimensions.space8),
          _SettingsTile(
            icon: Icons.notifications,
            title: 'Push Notifications',
            subtitle: 'Receive push notifications',
            trailing: Switch(
              value: _pushNotifications,
              activeThumbColor: AppColors.nexusBlue,
              onChanged: (value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
          ),
          _SettingsTile(
            icon: Icons.email,
            title: 'Email Notifications',
            subtitle: 'Receive email updates',
            trailing: Switch(
              value: _emailNotifications,
              activeThumbColor: AppColors.nexusBlue,
              onChanged: (value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Privacy
          const _SectionHeader(title: 'Privacy'),
          const SizedBox(height: AppDimensions.space8),
          _SettingsTile(
            icon: Icons.lock,
            title: 'Private Profile',
            subtitle: 'Only followers can see your posts',
            trailing: Switch(
              value: _privateProfile,
              activeThumbColor: AppColors.nexusBlue,
              onChanged: (value) {
                setState(() {
                  _privateProfile = value;
                });
              },
            ),
          ),
          _SettingsTile(
            icon: Icons.circle,
            title: 'Show Online Status',
            subtitle: 'Let others see when you\'re online',
            trailing: Switch(
              value: _showOnlineStatus,
              activeThumbColor: AppColors.nexusBlue,
              onChanged: (value) {
                setState(() {
                  _showOnlineStatus = value;
                });
              },
            ),
          ),

          const SizedBox(height: AppDimensions.space24),

          // Account
          const _SectionHeader(title: 'Account'),
          const SizedBox(height: AppDimensions.space8),
          _SettingsTile(
            icon: Icons.password,
            title: 'Change Password',
            subtitle: 'Update your password',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset link sent to your email.'),
                  backgroundColor: AppColors.karmaVerified,
                ),
              );
            },
          ),
          _SettingsTile(
            icon: Icons.block,
            title: 'Blocked Users',
            subtitle: 'Manage blocked accounts',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Blocked users management coming soon'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
            },
          ),

          const SizedBox(height: AppDimensions.space24),

          // About
          const _SectionHeader(title: 'About'),
          const SizedBox(height: AppDimensions.space8),
          _SettingsTile(
            icon: Icons.info,
            title: 'About Nexus',
            subtitle: 'Version 1.0.0',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          _SettingsTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
            onTap: () {
              context.pushNamed('privacy-settings');
            },
          ),
          _SettingsTile(
            icon: Icons.description,
            title: 'Terms of Service',
            subtitle: 'Read our terms',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Terms of Service coming soon'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
            },
          ),

          const SizedBox(height: AppDimensions.space24),

          // Logout
          _SettingsTile(
            icon: Icons.logout,
            title: 'Logout',
            subtitle: 'Sign out of your account',
            titleColor: AppColors.errorFlare,
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkMatter,
        title: Text(
          'About Nexus',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  AppColors.nexusBlue,
                  AppColors.cyberPurple,
                ],
              ).createShader(bounds),
              child: Text(
                'NEXUS',
                style: AppTypography.headlineLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.space16),
            Text(
              'Version 1.0.0',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.space8),
            Text(
              'A cyberpunk social network for the digital age',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.nexusBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkMatter,
        title: Text(
          'Logout',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // A real implementation would call auth provider logout here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: AppColors.nexusBlue,
                ),
              );
              context.goNamed('login');
            },
            child: Text(
              'Logout',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.errorFlare,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTypography.titleSmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.space8),
      decoration: BoxDecoration(
        color: AppColors.glassLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        border: Border.all(
          color: AppColors.carbonFiber,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: titleColor ?? AppColors.textSecondary,
        ),
        title: Text(
          title,
          style: AppTypography.bodyLarge.copyWith(
            color: titleColor ?? AppColors.textPrimary,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              )
            : null,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
