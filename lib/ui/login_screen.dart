import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import 'home_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate login process
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final screenHeight = ResponsiveUtils.getScreenHeight(context);
    final screenWidth = ResponsiveUtils.getScreenWidth(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFFF8F9FA),
                ],
              ),
            ),
          ),

          // Top illustration
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeController,
              child: Image.asset(
                'assets/images/bg_login_top.png',
                width: screenWidth,
                height: screenHeight * 0.35,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top spacing
                  SizedBox(height: screenHeight * 0.05),

                  // Login form card
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _slideController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Container(
                      margin: EdgeInsets.all(
                        isMobile ? AppTheme.spacingM : AppTheme.spacingL,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(AppTheme.radiusXXL),
                        boxShadow: AppTheme.shadowL,
                      ),
                      child: ResponsiveContainer(
                        padding: EdgeInsets.all(
                          isMobile ? AppTheme.spacingL : AppTheme.spacingXL,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Logo
                              Container(
                                padding: const EdgeInsets.all(AppTheme.spacingL),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/titan_logo_new.svg',
                                  height: isMobile ? 50 : 60,
                                  width: isMobile ? 50 : 60,
                                ),
                              ),
                              
                              SizedBox(height: AppTheme.spacingL),

                              // Title
                              Text(
                                'Welcome Back',
                                style: AppTheme.heading3.copyWith(
                                  fontSize: ResponsiveUtils.getResponsiveFontSize(
                                    context,
                                    isMobile ? 24 : 28,
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: AppTheme.spacingS),

                              // Subtitle
                              Text(
                                'Sign in to your account to continue',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              SizedBox(height: AppTheme.spacingXL),

                              // Email Field
                              AppTextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                label: 'Email Address',
                                hint: 'Enter your email',
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: AppTheme.textSecondary,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              
                              SizedBox(height: AppTheme.spacingM),

                              // Password Field
                              AppTextField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                label: 'Password',
                                hint: 'Enter your password',
                                prefixIcon: const Icon(
                                  Icons.lock_outlined,
                                  color: AppTheme.textSecondary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                    color: AppTheme.textSecondary,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              
                              SizedBox(height: AppTheme.spacingM),

                              // Remember me and Forgot password
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            _rememberMe = value ?? false;
                                          });
                                        },
                                        activeColor: AppTheme.primaryColor,
                                      ),
                                      Text(
                                        'Remember me',
                                        style: AppTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle forgot password
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: AppTheme.spacingL),

                              // Login Button
                              AppButton(
                                label: 'Sign In',
                                onPressed: _handleLogin,
                                isLoading: _isLoading,
                                variant: AppButtonVariant.primary,
                                size: AppButtonSize.large,
                                fullWidth: true,
                                trailing: const Icon(Icons.login_rounded, size: 20),
                              ),
                              
                              SizedBox(height: AppTheme.spacingL),

                              // Divider
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: AppTheme.borderColor,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppTheme.spacingM,
                                    ),
                                    child: Text(
                                      'OR',
                                      style: AppTheme.bodySmall,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: AppTheme.borderColor,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: AppTheme.spacingL),

                              // Update Configuration Button
                              AppButton(
                                label: 'Update Configuration',
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/configuration');
                                },
                                variant: AppButtonVariant.outline,
                                size: AppButtonSize.medium,
                                fullWidth: true,
                                icon: Icons.settings_outlined,
                              ),
                              
                              SizedBox(height: AppTheme.spacingL),

                              // Sign up link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigate to sign up
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: AppTheme.bodyMedium.copyWith(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
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
                  
                  // Bottom spacing
                  SizedBox(height: AppTheme.spacingL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}