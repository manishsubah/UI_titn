import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
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
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/titan_logo_new.svg',
              height: 28,
              width: 28,
            ),
            const SizedBox(width: AppTheme.spacingS),
            Flexible(
              child: Text(
                'Titan Dashboard',
                style: AppTheme.heading4.copyWith(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: AppTheme.surfaceColor,
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppTheme.spacingL),

              // Welcome Section
              FadeTransition(
                opacity: _fadeController,
                child: AppCard(
                  variant: AppCardVariant.elevated,
                  padding: EdgeInsets.all(isMobile ? AppTheme.spacingL : AppTheme.spacingXL),
                  color: AppTheme.primaryColor,
                  child: Container(
                    decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back! 👋',
                          style: AppTheme.heading3.copyWith(
                            color: Colors.white,
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              isMobile ? 20 : 24,
                            ),
                          ),
                        ),
                        SizedBox(height: AppTheme.spacingS),
                        Text(
                          'Ready to test brilliantly? Let\'s get started with your next project.',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Quick Stats Section
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.easeOutCubic,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Stats',
                      style: AppTheme.heading4.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          isMobile ? 18 : 20,
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingM),

                    // Stats Grid
                    ResponsiveLayout(
                      mobile: _buildStatsGrid(context, 2),
                      tablet: _buildStatsGrid(context, 4),
                      desktop: _buildStatsGrid(context, 4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Recent Projects Section
              FadeTransition(
                opacity: _fadeController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Projects',
                          style: AppTheme.heading4.copyWith(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              isMobile ? 18 : 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacingM),

                    _buildProjectsList(),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, int crossAxisCount) {
    final stats = [
      {'title': 'Active Tests', 'value': '24', 'icon': Icons.play_circle_outline, 'color': AppTheme.successColor},
      {'title': 'Completed', 'value': '156', 'icon': Icons.check_circle_outline, 'color': AppTheme.primaryColor},
      {'title': 'Failed', 'value': '3', 'icon': Icons.error_outline, 'color': AppTheme.errorColor},
      {'title': 'Success Rate', 'value': '98%', 'icon': Icons.trending_up, 'color': AppTheme.warningColor},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.55,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingS),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        stat['value'] as String,
                        style: AppTheme.heading3.copyWith(
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: (stat['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      child: Icon(
                        stat['icon'] as IconData,
                        color: stat['color'] as Color,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  stat['title'] as String,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectsList() {
    final projects = [
      {
        'name': 'E-commerce App Testing',
        'status': 'In Progress',
        'progress': 0.75,
        'color': AppTheme.primaryColor,
      },
      {
        'name': 'Mobile Banking Security',
        'status': 'Completed',
        'progress': 1.0,
        'color': AppTheme.successColor,
      },
      {
        'name': 'API Integration Test',
        'status': 'Pending',
        'progress': 0.0,
        'color': AppTheme.warningColor,
      },
    ];

    return Column(
      children: projects.map((project) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: project['color'] as Color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project['name'] as String,
                        style: AppTheme.heading4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingXS),
                      Text(
                        project['status'] as String,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppTheme.spacingM),
                SizedBox(
                  width: 60,
                  child: LinearProgressIndicator(
                    value: project['progress'] as double,
                    backgroundColor: AppTheme.borderLight,
                    valueColor: AlwaysStoppedAnimation<Color>(project['color'] as Color),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
} 