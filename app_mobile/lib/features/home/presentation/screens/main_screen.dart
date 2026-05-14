import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

/// 🏠 **Pantalla Principal (Shell)**
///
/// Contenedor principal que implementa la barra de navegación inferior.
/// Mantiene el estado de las pestañas (Feed, Search, Chat, Profile).
class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    required this.navigationShell,
    super.key,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        backgroundColor: AppColors.voidBlack,
        indicatorColor: AppColors.nexusBlue.withValues(alpha: 0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppColors.nexusBlue),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search, color: AppColors.nexusBlue),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble, color: AppColors.nexusBlue),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.nexusBlue),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
