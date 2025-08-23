import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';

class WidgetsScreen extends StatefulWidget {
  const WidgetsScreen({super.key});

  @override
  State<WidgetsScreen> createState() => _WidgetsScreenState();
}

class _WidgetsScreenState extends State<WidgetsScreen> {
  int _selectedTabIndex = 1; // Start with "My Widgets" selected as shown in image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2E), // Dark grey background as shown
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Tab Navigation
            _buildTabNavigation(),
            
            // Widgets Content
            Expanded(
              child: _buildWidgetsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        children: [
          // Profile Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // Portal Title with Dropdown
          Expanded(
            child: Row(
              children: [
                Text(
                  'Titan Default Portal',
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
          
          // Notification Icon
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          
          // Grid Menu Icon
          IconButton(
            icon: const Icon(
              Icons.grid_view_outlined,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Row(
        children: [
          // All Tab
          Expanded(
            child: _buildTabButton(
              title: 'All',
              isSelected: _selectedTabIndex == 0,
              onTap: () => setState(() => _selectedTabIndex = 0),
            ),
          ),
          
          const SizedBox(width: AppTheme.spacingM),
          
          // My Widgets Tab
          Expanded(
            child: _buildTabButton(
              title: 'My Widgets',
              isSelected: _selectedTabIndex == 1,
              onTap: () => setState(() => _selectedTabIndex = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          border: isSelected 
            ? null 
            : Border.all(color: Colors.white, width: 1),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTheme.bodyMedium.copyWith(
            color: isSelected ? Colors.white : Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetsContent() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingM),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.1,
        children: [
          // Test Timer Widget
          _buildWidgetCard(
            value: '10',
            title: 'Test Timer',
            icon: Icons.assignment_turned_in,
            color: AppTheme.primaryColor,
          ),
          
          // Checkouts Widget
          _buildWidgetCard(
            value: '100+',
            title: 'Checkouts',
            icon: Icons.assignment_turned_in,
            color: AppTheme.successColor,
          ),
          
          // Today's Activities Widget
          _buildWidgetCard(
            value: '19',
            title: 'Today\'s Activities',
            icon: Icons.assignment_turned_in,
            color: AppTheme.warningColor,
          ),
          
          // Add Widget Card
          _buildAddWidgetCard(),
        ],
      ),
    );
  }

  Widget _buildWidgetCard({
    required String value,
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.shadowS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with value and icon
            Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: AppTheme.heading2.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingS),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
              ],
            ),
            
            const Spacer(),
            
            // Title
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddWidgetCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(color: Colors.grey[400]!, width: 1),
      ),
      child: const Center(
        child: Icon(
          Icons.add,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }
}
