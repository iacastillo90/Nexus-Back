import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import 'ai_agents_hub_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.voidBlack,
        appBar: AppBar(
          title: const Text('Nexus Comms'),
          bottom: const TabBar(
            indicatorColor: AppColors.nexusBlue,
            labelColor: AppColors.nexusBlue,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'Chats'),
              Tab(text: 'Mentores (AI)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Regular Chats
            ListView(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF9C27B0),
                    child: Icon(Icons.psychology, color: Colors.white),
                  ),
                  title: const Text(
                    'Dr. Luma',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    'Expert in emotional intelligence',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  onTap: () {
                    context.push('/chats/room/11111111-1111-1111-1111-111111111111');
                  },
                ),
                // Add more chat items here
              ],
            ),
            // Tab 2: Council Hall (AI Agents)
            const AIAgentsHubScreen(),
          ],
        ),
      ),
    );
  }
}
