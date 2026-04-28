import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/widgets/widgets.dart';

/// Onboarding screen with 3 slides
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.hub,
      title: 'Welcome to Nexus',
      description:
          'Your digital consciousness platform. Connect, share, and evolve in a new dimension of social interaction.',
      color: AppColors.nexusBlue,
    ),
    OnboardingPage(
      icon: Icons.psychology,
      title: 'AI-Powered Insights',
      description:
          'Chat with AI mentors like The Echo, Dr. Luma, and Cipher. Get personalized guidance and predictions.',
      color: AppColors.cyberPurple,
    ),
    OnboardingPage(
      icon: Icons.verified_user,
      title: 'Karma & Authenticity',
      description:
          'Build your reputation with Karma scores. Content DNA ensures authenticity in every post.',
      color: AppColors.plasmaGreen,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/auth/login');
    }
  }

  void _skip() {
    context.go('/auth/login');
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
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Skip',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildIndicator(index == _currentPage),
                ),
              ),

              const SizedBox(height: AppDimensions.space32),

              // Next/Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.space24,
                ),
                  child: NexusButton(
                    onPressed: _nextPage,
                    width: double.infinity,
                    text: _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
              ),

              const SizedBox(height: AppDimensions.space32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.space32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with glow
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: page.color.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
              color: AppColors.darkMatter,
            ),
            child: Icon(
              page.icon,
              size: 64,
              color: page.color,
            ),
          ),

          const SizedBox(height: AppDimensions.space48),

          // Title
          Text(
            page.title,
            style: AppTypography.headlineLarge.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.space16),

          // Description
          Text(
            page.description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.nexusBlue : AppColors.carbonFiber,
        borderRadius: BorderRadius.circular(4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.nexusBlue.withValues(alpha: 0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
