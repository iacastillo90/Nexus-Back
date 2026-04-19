import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexus_mobile/features/auth/presentation/providers/auth_providers.dart';
import 'package:nexus_mobile/features/auth/presentation/screens/splash_screen.dart';
import 'package:nexus_mobile/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:nexus_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:nexus_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:nexus_mobile/features/auth/presentation/screens/biometric_setup_screen.dart';
import 'package:nexus_mobile/features/feed/presentation/screens/feed_screen.dart';
import 'package:nexus_mobile/features/feed/presentation/screens/post_detail_screen.dart';
import 'package:nexus_mobile/features/content/presentation/screens/create_post_screen.dart';
import 'package:nexus_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:nexus_mobile/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:nexus_mobile/features/profile/presentation/screens/karma_hub_screen.dart';
import 'package:nexus_mobile/features/settings/presentation/screens/settings_screen.dart';
import 'package:nexus_mobile/features/settings/presentation/screens/echo_settings_screen.dart';
import 'package:nexus_mobile/features/settings/presentation/screens/privacy_settings_screen.dart';
import 'package:nexus_mobile/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:nexus_mobile/features/chat/presentation/screens/chat_room_screen.dart';
import 'package:nexus_mobile/features/reality_layers/presentation/screens/layer_selector_screen.dart';
import 'package:nexus_mobile/features/reality_layers/presentation/screens/reality_map_screen.dart';
import 'package:nexus_mobile/features/vibes/presentation/screens/vibes_dashboard_screen.dart';
import 'package:nexus_mobile/features/vibes/presentation/screens/prism_insights_screen.dart';
import 'package:nexus_mobile/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:nexus_mobile/features/search/presentation/screens/search_screen.dart';
import 'package:nexus_mobile/features/home/presentation/screens/main_screen.dart';
import 'package:nexus_mobile/features/profile/domain/entities/karma_entity.dart';
import 'package:nexus_mobile/features/verify/presentation/screens/digital_certificate_screen.dart';
import 'package:nexus_mobile/features/content/presentation/screens/voice_cloning_screen.dart';
import 'package:nexus_mobile/features/challenges/presentation/screens/challenges_screen.dart';

/// GoRouter configuration for Nexus app
final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isLoading = authState.isLoading;

      // Don't redirect while loading
      if (isLoading) return null;

      final isSplash = state.matchedLocation == '/splash';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isAuth = state.matchedLocation.startsWith('/auth');

      // If authenticated and trying to access auth pages, redirect to home
      if (isAuthenticated && (isAuth || isSplash || isOnboarding)) {
        return '/home';
      }

      // If not authenticated and trying to access protected pages, redirect to login
      if (!isAuthenticated && !isAuth && !isSplash && !isOnboarding) {
        return '/auth/login';
      }

      return null;
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding Screen
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/biometric-setup',
        name: 'biometric-setup',
        builder: (context, state) => const BiometricSetupScreen(),
      ),

      // Main App Shell (Bottom Navigation)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Feed
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const FeedScreen(),
                routes: [
                  GoRoute(
                    path: 'post/:postId',
                    name: 'post-detail',
                    builder: (context, state) {
                      final postId = state.pathParameters['postId']!;
                      return PostDetailScreen(postId: postId);
                    },
                  ),
                  GoRoute(
                    path: 'create-post',
                    name: 'create-post',
                    builder: (context, state) => const CreatePostScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 2: Search
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: 'search',
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),

          // Branch 3: Chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chats',
                name: 'chats',
                builder: (context, state) => const ChatListScreen(),
                routes: [
                  GoRoute(
                    path: 'room/:mentorId',
                    name: 'chat-room',
                    builder: (context, state) {
                      final mentorId = state.pathParameters['mentorId']!;
                      return ChatRoomScreen(mentorId: mentorId);
                    },
                  ),
                ],
              ),
            ],
          ),

          // Branch 4: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    name: 'edit-profile',
                    builder: (context, state) => const EditProfileScreen(),
                  ),
                  GoRoute(
                    path: 'karma',
                    name: 'karma-detail',
                    builder: (context, state) {
                      // Mocking KarmaEntity for demo if not passed
                      // In real app, get from state.extra or fetch
                      const mockKarma = KarmaEntity(
                        totalScore: 850,
                        authenticityScore: 90,
                        contributionScore: 80,
                        communityScore: 85,
                        consistencyScore: 95,
                        tier: 'verified',
                        tierProgress: 0.7,
                        privileges: ['voice_clone', 'reality_layers', 'priority_support'],
                      );
                      return const KarmaHubScreen(karma: mockKarma);
                    },
                  ),
                  GoRoute(
                    path: 'settings',
                    name: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                    routes: [
                      GoRoute(
                        path: 'echo',
                        name: 'echo-settings',
                        builder: (context, state) => const EchoSettingsScreen(),
                      ),
                      GoRoute(
                        path: 'privacy',
                        name: 'privacy-settings',
                        builder: (context, state) => const PrivacySettingsScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Verify Certificate
      GoRoute(
        path: '/verify/certificate',
        name: 'certificate',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DigitalCertificateScreen(
            contentDNA: extra['contentDNA'] as String,
            authorUsername: extra['authorUsername'] as String,
            timestamp: extra['timestamp'] as String,
          );
        },
      ),

      // Reality Layers (Accessible globally or via specific entry point)
      GoRoute(
        path: '/layers',
        name: 'layers',
        builder: (context, state) => const LayerSelectorScreen(),
      ),
      // Deep Link Top Level Post Route
      GoRoute(
        path: '/post/:postId',
        name: 'deep-link-post',
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return PostDetailScreen(postId: postId);
        },
      ),
      GoRoute(
        path: '/reality-map',
        name: 'reality-map',
        builder: (context, state) => const RealityMapScreen(),
      ),
      GoRoute(
        path: '/vibes',
        name: 'vibes',
        builder: (context, state) => const VibesDashboardScreen(),
        routes: [
          GoRoute(
            path: 'prism',
            name: 'prism',
            builder: (context, state) => const PrismInsightsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/content/voice-cloning',
        name: 'voice-cloning',
        builder: (context, state) => const VoiceCloningScreen(),
      ),
      GoRoute(
        path: '/challenges',
        name: 'challenges',
        builder: (context, state) => const ChallengesScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
});
