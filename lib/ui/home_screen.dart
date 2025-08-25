import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';
import 'widgets_screen.dart';
import 'inventory_screen.dart';

/// Simple blank white home page shell shown after configuration setup
/// Uses a custom bottom navigation with SVG icons from assets/icons
class TitanHomePage extends StatefulWidget {
  const TitanHomePage({super.key});

  @override
  State<TitanHomePage> createState() => _TitanHomePageState();
}

class _TitanHomePageState extends State<TitanHomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    setState(() => _currentIndex = index);
  }

  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show different screens based on selected tab
    switch (_currentIndex) {
      case 3: // Inventory tab
        return const InventoryScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    final isMobile = ResponsiveUtils.isMobile(context);
    // final isTablet = ResponsiveUtils.isTablet(context);

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

                    // Projects List
                    _buildProjectsList(context),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Quick Actions Section
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
                      'Quick Actions',
                      style: AppTheme.heading4.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          isMobile ? 18 : 20,
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingM),

                    // Actions Grid
                    ResponsiveLayout(
                      mobile: _buildActionsGrid(context, 2),
                      tablet: _buildActionsGrid(context, 3),
                      desktop: _buildActionsGrid(context, 4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Widgets Section
              FadeTransition(
                opacity: _fadeController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Widgets',
                          style: AppTheme.heading4.copyWith(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              isMobile ? 18 : 20,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WidgetsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.dashboard_outlined),
                          label: const Text('View Widgets'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingL,
                              vertical: AppTheme.spacingM,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusM),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacingM),

                    // Widgets Preview
                    _buildWidgetsPreview(context),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
      bottomNavigationBar: TitanBottomNav(
        items: const [
          TitanNavItem(asset: 'assets/icons/home.svg', label: 'Home'),
          TitanNavItem(asset: 'assets/icons/test_request.svg', label: 'Test Request'),
          TitanNavItem(asset: 'assets/icons/work_order.svg', label: 'Work Order'),
          TitanNavItem(asset: 'assets/icons/test_article.svg', label: 'Inventory'),
          TitanNavItem(asset: 'assets/icons/reporting.svg', label: 'Reporting'),
        ],
        currentIndex: _currentIndex,
        onTap: _onTabChange,
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
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final widget = stats[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget['value'] as String,
                      style: AppTheme.heading3.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingS),
                    decoration: BoxDecoration(
                      color: (widget['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: widget['color'] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingS),
              Text(
                widget['title'] as String,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectsList(BuildContext context) {
    final projects = [
      {'name': 'E-commerce App Testing', 'status': 'In Progress', 'progress': 0.75, 'color': AppTheme.primaryColor},
      {'name': 'Mobile Banking Security', 'status': 'Completed', 'progress': 1.0, 'color': AppTheme.successColor},
      {'name': 'API Performance Test', 'status': 'Pending', 'progress': 0.0, 'color': AppTheme.warningColor},
    ];

    return Column(
      children: projects.map((project) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 40,
                decoration: BoxDecoration(
                  color: project['color'] as Color,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
              ),
              SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['name'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXS),
                    Text(
                      project['status'] as String,
                      style: AppTheme.bodySmall,
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    project['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionsGrid(BuildContext context, int crossAxisCount) {
    final actions = [
      {'value': '', 'title': 'New Test', 'icon': Icons.add_circle_outline, 'color': AppTheme.primaryColor},
      {'value': '', 'title': 'Import Project', 'icon': Icons.file_upload_outlined, 'color': AppTheme.successColor},
      {'value': '', 'title': 'Generate Report', 'icon': Icons.assessment_outlined, 'color': AppTheme.warningColor},
      {'value': '', 'title': 'Settings', 'icon': Icons.settings_outlined, 'color': AppTheme.secondaryColor},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final widget = actions[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget['value'] as String,
                      style: AppTheme.heading3.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingS),
                    decoration: BoxDecoration(
                      color: (widget['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: widget['color'] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingS),
              Text(
                widget['title'] as String,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWidgetsPreview(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return ResponsiveLayout(
      mobile: _buildWidgetsGrid(context, 2),
      tablet: _buildWidgetsGrid(context, 3),
      desktop: _buildWidgetsGrid(context, 4),
    );
  }

  Widget _buildWidgetsGrid(BuildContext context, int crossAxisCount) {
    final widgets = [
      {'value': '10', 'title': 'Test Timer', 'color': AppTheme.primaryColor},
      {'value': '100+', 'title': 'Checkouts', 'color': AppTheme.successColor},
      {'value': '19', 'title': 'Today\'s Activities', 'color': AppTheme.warningColor},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.5,
      ),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final widget = widgets[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget['value'] as String,
                      style: AppTheme.heading3.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingS),
                    decoration: BoxDecoration(
                      color: (widget['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: widget['color'] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingS),
              Text(
                widget['title'] as String,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TitanNavItem {
  final String asset;
  final String label;
  const TitanNavItem({required this.asset, required this.label});
}

class TitanBottomNav extends StatelessWidget {
  final List<TitanNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const TitanBottomNav({super.key, required this.items, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          boxShadow: AppTheme.shadowM,
        ),
        height: kBottomNavigationBarHeight + 12,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              for (int i = 0; i < items.length; i++)
                _NavButton(
                  item: items[i],
                  selected: i == currentIndex,
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final TitanNavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _NavButton({required this.item, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = selected ? AppTheme.primaryColor : AppTheme.textSecondary;
    final TextStyle labelStyle = AppTheme.bodySmall.copyWith(
      color: selected ? AppTheme.primaryColor : AppTheme.textSecondary,
      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      fontSize: 11,
      height: 1.05,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        onTap: onTap,
        child: Container(
          width: 86,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppTheme.primaryColor.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item.asset,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: labelStyle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    // final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/images/titan_logo_new.svg',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: AppTheme.spacingS),
            Text(
              'Titan Dashboard',
              style: AppTheme.heading4,
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
                    
                    // Projects List
                    _buildProjectsList(context),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Quick Actions Section
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
                      'Quick Actions',
                      style: AppTheme.heading4.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(
                          context,
                          isMobile ? 18 : 20,
                        ),
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingM),
                    
                    // Actions Grid
                    ResponsiveLayout(
                      mobile: _buildActionsGrid(context, 2),
                      tablet: _buildActionsGrid(context, 3),
                      desktop: _buildActionsGrid(context, 4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Widgets Section
              FadeTransition(
                opacity: _fadeController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Widgets',
                          style: AppTheme.heading4.copyWith(
                            fontSize: ResponsiveUtils.getResponsiveFontSize(
                              context,
                              isMobile ? 18 : 20,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WidgetsScreen(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.dashboard_outlined),
                          label: const Text('View Widgets'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingL,
                              vertical: AppTheme.spacingM,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.radiusM),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacingM),
                    
                    // Widgets Preview
                    _buildWidgetsPreview(context),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        backgroundColor: AppTheme.surfaceColor,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
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
                SizedBox(height: 6),
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

  Widget _buildProjectsList(BuildContext context) {
    final projects = [
      {'name': 'E-commerce App Testing', 'status': 'In Progress', 'progress': 0.75, 'color': AppTheme.primaryColor},
      {'name': 'Mobile Banking Security', 'status': 'Completed', 'progress': 1.0, 'color': AppTheme.successColor},
      {'name': 'API Performance Test', 'status': 'Pending', 'progress': 0.0, 'color': AppTheme.warningColor},
    ];

    return Column(
      children: projects.map((project) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 40,
                decoration: BoxDecoration(
                  color: project['color'] as Color,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
              ),
              SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project['name'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXS),
                    Text(
                      project['status'] as String,
                      style: AppTheme.bodySmall,
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                    project['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionsGrid(BuildContext context, int crossAxisCount) {
    final actions = [
      {'title': 'New Test', 'icon': Icons.add_circle_outline, 'color': AppTheme.primaryColor},
      {'title': 'Import Project', 'icon': Icons.file_upload_outlined, 'color': AppTheme.successColor},
      {'title': 'Generate Report', 'icon': Icons.assessment_outlined, 'color': AppTheme.warningColor},
      {'title': 'Settings', 'icon': Icons.settings_outlined, 'color': AppTheme.secondaryColor},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return AppCard(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(AppTheme.radiusL),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingS),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                                             decoration: BoxDecoration(
                         color: (action['color'] as Color).withOpacity(0.1),
                         borderRadius: BorderRadius.circular(AppTheme.radiusL),
                       ),
                      child: Icon(
                        action['icon'] as IconData,
                        color: action['color'] as Color,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingM),
                    Text(
                      action['title'] as String,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWidgetsPreview(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    
    return ResponsiveLayout(
      mobile: _buildWidgetsGrid(context, 2),
      tablet: _buildWidgetsGrid(context, 3),
      desktop: _buildWidgetsGrid(context, 4),
    );
  }

  Widget _buildWidgetsGrid(BuildContext context, int crossAxisCount) {
    final widgets = [
      {'value': '10', 'title': 'Test Timer', 'color': AppTheme.primaryColor},
      {'value': '100+', 'title': 'Checkouts', 'color': AppTheme.successColor},
      {'value': '19', 'title': 'Today\'s Activities', 'color': AppTheme.warningColor},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.5,
      ),
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        final widget = widgets[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget['value'] as String,
                      style: AppTheme.heading3.copyWith(
                        fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacingS),
                    decoration: BoxDecoration(
                      color: (widget['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: widget['color'] as Color,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingS),
              Text(
                widget['title'] as String,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 