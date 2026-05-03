import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';

class AIAgentsHubScreen extends StatelessWidget {
  const AIAgentsHubScreen({super.key});

  final List<Map<String, dynamic>> agents = const [
    {
      'id': '11111111-1111-1111-1111-111111111111', // Dr. Luma
      'name': 'Dr. Luma',
      'role': 'Psychologist',
      'color': Color(0xFF9C27B0), // Violet
      'description': 'Expert in emotional intelligence and mental well-being.',
      'icon': Icons.psychology,
    },
    {
      'id': '22222222-2222-2222-2222-222222222222', // Prof. Nova
      'name': 'Prof. Nova',
      'role': 'Scientist',
      'color': Color(0xFF2196F3), // Blue
      'description': 'Specialist in quantum physics and advanced technology.',
      'icon': Icons.science,
    },
    {
      'id': '33333333-3333-3333-3333-333333333333', // Kai
      'name': 'Kai',
      'role': 'Hacker / Chaos',
      'color': Color(0xFFFF5722), // Deep Orange
      'description': 'Master of digital disruption and unconventional solutions.',
      'icon': Icons.code,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: agents.length,
        itemBuilder: (context, index) {
          final agent = agents[index];
          return _buildAgentCard(context, agent)
              .animate()
              .fadeIn(duration: 600.ms, delay: (200 * index).ms)
              .slideX(begin: 0.2, end: 0);
        },
      ),
    );
  }

  Widget _buildAgentCard(BuildContext context, Map<String, dynamic> agent) {
    return GestureDetector(
      onTap: () {
        context.push('/chats/room/${agent['id']}');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 160,
        decoration: BoxDecoration(
          color: AppColors.deepSpace,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: (agent['color'] as Color).withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (agent['color'] as Color).withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      (agent['color'] as Color).withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Avatar Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(
                        color: agent['color'] as Color,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (agent['color'] as Color).withValues(alpha: 0.4),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Icon(
                      agent['icon'] as IconData,
                      color: agent['color'] as Color,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          agent['name'] as String,
                          style: AppTypography.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: (agent['color'] as Color).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            (agent['role'] as String).toUpperCase(),
                            style: AppTypography.labelSmall.copyWith(
                              color: agent['color'] as Color,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          agent['description'] as String,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Arrow
                  Icon(
                    Icons.arrow_forward_ios,
                    color: (agent['color'] as Color).withValues(alpha: 0.5),
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
