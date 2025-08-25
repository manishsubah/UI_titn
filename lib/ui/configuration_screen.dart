import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_button.dart';
// import '../widgets/app_card.dart';
import '../widgets/app_label.dart';
import '../widgets/app_url_field.dart';
import '../widgets/app_qr_button.dart';
import '../widgets/app_divider.dart';
import 'main_navigation_screen.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill with default URL
    _urlController.text = 'https://titaniden.titan410-c3.12thwonder.com';
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _handleSetup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate setup process
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Navigate to Home after setup
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    }
  }

  void _handleScanQrCode() {
    // Handle QR code scanning
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('QR Code scanning feature coming soon!'),
        backgroundColor: AppTheme.infoColor,
      ),
    );
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

          // Top illustration section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.35,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F8FF),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for the diagram image
                    Container(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(AppTheme.radiusL),
                        border: Border.all(color: AppTheme.borderLight),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_tree_outlined,
                            size: 48,
                            color: AppTheme.primaryColor.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          Text(
                            'Configuration Flow',
                            style: AppTheme.heading4.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingS),
                          Text(
                            '01 PLANNING • 02 DATA ANALYSIS • 03 SCHEDULING\n04 DATA MANAGEMENT • 05 EXECUTION',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textMuted,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: screenHeight * 0.05),

                // Configuration card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppTheme.radiusXXL),
                        topRight: Radius.circular(AppTheme.radiusXXL),
                      ),
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
                            // Logo and branding
                            Container(
                              padding: const EdgeInsets.all(AppTheme.spacingL),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/titan_logo_new.svg',
                                    height: 32,
                                    width: 32,
                                  ),
                                  const SizedBox(width: AppTheme.spacingS),
                                ],
                              ),
                            ),

                            SizedBox(height: AppTheme.spacingXL),

                            // Main heading
                            Text(
                              'Enter Your Web Application URL',
                              style: AppTheme.heading3.copyWith(
                                fontSize: ResponsiveUtils.getResponsiveFontSize(
                                  context,
                                  isMobile ? 20 : 24,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: AppTheme.spacingL),

                            // URL input section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppLabel(
                                  text: 'Enter URL below',
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: AppTheme.spacingS),
                                AppUrlField(
                                  controller: _urlController,
                                  onChanged: (value) {
                                    // Handle URL changes
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: AppTheme.spacingL),

                            // Setup button
                            AppButton(
                              label: 'Setup',
                              onPressed: _handleSetup,
                              isLoading: _isLoading,
                              variant: AppButtonVariant.primary,
                              size: AppButtonSize.large,
                              fullWidth: true,
                            ),

                            SizedBox(height: AppTheme.spacingL),

                            // Divider
                            const AppDivider(text: 'or'),

                            SizedBox(height: AppTheme.spacingL),

                            // QR Code button
                            AppQrButton(
                              label: 'Scan QR Code',
                              onPressed: _handleScanQrCode,
                              icon: Icons.qr_code_scanner,
                            ),

                            SizedBox(height: AppTheme.spacingL),

                            // Instructional text
                            Text(
                              'Find above mobile config icon on web application main header and scan using below scan button.',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textMuted,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const Spacer(),

                            // Back button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                                ),
                                child: IconButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppTheme.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              ),
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
