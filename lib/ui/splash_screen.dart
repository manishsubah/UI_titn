import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = ResponsiveUtils.getScreenHeight(context);
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    final isMobile = ResponsiveUtils.isMobile(context);

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
                height: screenHeight * 0.45,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: screenHeight * 0.1),
                
                // Logo and title section
                Expanded(
                  flex: 2,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _slideController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.8,
                            end: 1.0,
                          ).animate(CurvedAnimation(
                            parent: _scaleController,
                            curve: Curves.elasticOut,
                          )),
                          child: Container(
                            padding: const EdgeInsets.all(AppTheme.spacingL),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppTheme.radiusXXL),
                              boxShadow: AppTheme.shadowL,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/titan_logo_new.svg',
                              height: isMobile ? 60 : 80,
                              width: isMobile ? 60 : 80,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: AppTheme.spacingL),
                        
                        // Animated title
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'Welcome to Titan',
                              textStyle: AppTheme.heading2.copyWith(
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                  context, 
                                  isMobile ? 24 : 28,
                                ),
                              ),
                              speed: const Duration(milliseconds: 100),
                            ),
                          ],
                          totalRepeatCount: 1,
                        ),
                        
                        const SizedBox(height: AppTheme.spacingM),
                        
                        // Subtitle
                        FadeTransition(
                          opacity: _fadeController,
                          child: Text(
                            'Test Brilliantly',
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom card section
                Expanded(
                  flex: 1,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _slideController,
                      curve: Curves.easeOutCubic,
                    )),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppTheme.radiusXXL),
                          topRight: Radius.circular(AppTheme.radiusXXL),
                        ),
                        boxShadow: AppTheme.shadowM,
                      ),
                      child: ResponsiveContainer(
                        padding: EdgeInsets.all(
                          isMobile ? AppTheme.spacingL : AppTheme.spacingXL,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Description text
                            Text(
                              'Experience the future of testing with our innovative platform',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textSecondary,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            SizedBox(height: isMobile ? AppTheme.spacingL : AppTheme.spacingXL),
                            
                            // Get Started Button
                            SizedBox(
                              width: isMobile ? double.infinity : 250,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          const LoginScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(opacity: animation, child: child);
                                      },
                                      transitionDuration: const Duration(milliseconds: 500),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppTheme.radiusL),
                                  ),
                                  shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Started',
                                      style: AppTheme.buttonText.copyWith(
                                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                                          context, 
                                          isMobile ? 16 : 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.spacingS),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(height: AppTheme.spacingM),
                            
                            // Version info
                            Text(
                              'Version 1.0.0',
                              style: AppTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
