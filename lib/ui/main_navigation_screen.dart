import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import 'home_screen.dart';
import 'inventory_screen.dart';
import 'test_request_screen.dart';
import 'work_order_screen.dart';
import 'reporting_screen.dart';

/// Main navigation screen that acts as a container with bottom navigation
/// Similar to Android fragments, different screens are displayed based on selected tab
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // List of screens to display based on selected tab
  final List<Widget> _screens = [
    const HomeScreen(),
    const TestRequestScreen(),
    const WorkOrderScreen(),
    const InventoryScreen(),
    const ReportingScreen(),
  ];

  void _onTabChange(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
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
