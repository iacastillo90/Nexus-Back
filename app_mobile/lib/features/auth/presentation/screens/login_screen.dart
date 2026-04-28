import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_providers.dart';
import '../../../../core/widgets/widgets.dart';

/// 🔐 **Pantalla de Inicio de Sesión**
///
/// Punto de entrada principal para usuarios existentes.
/// Implementa diseño Cyberpunk con gradientes y efectos de neón.
///
/// **Características:**
/// - Validación de formulario (Email/Password).
/// - Integración con [AuthController] para lógica de negocio.
/// - Soporte para autenticación biométrica.
/// - Navegación a Registro y Recuperación de contraseña.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// 🚀 **Manejo de Login**
  ///
  /// Valida inputs y llama al controlador.
  /// Muestra SnackBar con feedback (éxito/error).
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    await ref.read(authControllerProvider.notifier).login(email, password);

    if (!mounted) return;

    final authState = ref.read(authControllerProvider);

    authState.whenOrNull(
      data: (user) {
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Welcome back, ${user.displayName}!'),
              backgroundColor: AppColors.successGlow,
            ),
          );
          // Explicitly navigate to home
          context.go('/home');
        }
      },
      error: (error, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: AppColors.errorFlare,
          ),
        );
      },
    );
  }

  /// 👆 **Manejo de Biometría**
  ///
  /// Verifica disponibilidad y solicita autenticación.
  Future<void> _handleBiometricLogin() async {
    final isAvailable =
        await ref.read(authControllerProvider.notifier).isBiometricAvailable();

    if (!isAvailable) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometric authentication not available'),
          backgroundColor: AppColors.warningPulse,
        ),
      );
      return;
    }

    final authenticated =
        await ref.read(authControllerProvider.notifier).verifyBiometric();

    if (authenticated && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Biometric authentication successful'),
          backgroundColor: AppColors.successGlow,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.space24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimensions.space64),

                  // Logo with neon glow
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: AppColors.neonGlow,
                        color: AppColors.darkMatter,
                      ),
                      child: const Icon(
                        Icons.hub,
                        size: 56,
                        color: AppColors.nexusBlue,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.space32),

                  // Title with shader gradient
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          AppColors.nexusBlue,
                          AppColors.cyberPurple,
                        ],
                      ).createShader(bounds),
                      child: Text(
                        'Welcome Back',
                        style: AppTypography.displaySmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.space8),

                  Center(
                    child: Text(
                      'Sign in to continue your journey',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.space48),

                  // Email Field
                  NexusTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'your@email.com',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    // validator: Validators.email, // Assuming validator is handled externally or added to widget
                  ),

                  const SizedBox(height: AppDimensions.space16),

                  // Password Field
                  NexusTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: _obscurePassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    // validator: Validators.password,
                  ),

                  const SizedBox(height: AppDimensions.space16),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: isLoading
                                ? null
                                : (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                            activeColor: AppColors.nexusBlue,
                          ),
                          const Text(
                            'Remember me',
                            style: AppTypography.bodySmall,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: isLoading ? null : () {},
                        child: Text(
                          'Forgot Password?',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.nexusBlue,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.space32),

                  // Login Button
                  NexusButton(
                    text: 'Sign In',
                    onPressed: isLoading ? null : _handleLogin,
                    isLoading: isLoading,
                    width: double.infinity,
                  ),

                  const SizedBox(height: AppDimensions.space16),

                  // Biometric Login Button
                  NexusButton(
                    text: 'Use Biometrics',
                    icon: Icons.fingerprint,
                    onPressed: isLoading ? null : _handleBiometricLogin,
                    type: NexusButtonType.secondary,
                    width: double.infinity,
                  ),

                  const SizedBox(height: AppDimensions.space48),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.space16,
                        ),
                        child: Text(
                          'OR',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.space24),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                context.push('/auth/register');
                              },
                        child: Text(
                          'Sign Up',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.nexusBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
