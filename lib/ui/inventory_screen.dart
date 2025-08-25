import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';
import 'home_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  int _selectedTabIndex = 1; // Start with "Parts" selected as shown in image
  int _currentPage = 1;
  final int _totalPages = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2E), // Dark grey background as shown
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            // Tab Navigation and Actions
            _buildTabNavigation(),
            
            // Inventory Content
            Expanded(
              child: _buildInventoryContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
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
          
          // Title and Portal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Inventory',
                  style: AppTheme.heading4.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Titan Default Portal',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
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
      child: Column(
        children: [
          // Tab Buttons
          Row(
            children: [
              // Stock Tab
              Expanded(
                child: _buildTabButton(
                  title: 'Stock',
                  isSelected: _selectedTabIndex == 0,
                  onTap: () => setState(() => _selectedTabIndex = 0),
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingM),
              
              // Parts Tab
              Expanded(
                child: _buildTabButton(
                  title: 'Parts',
                  isSelected: _selectedTabIndex == 1,
                  onTap: () => setState(() => _selectedTabIndex = 1),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          
          // Action Bar
          Row(
            children: [
              // New Button
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingL,
                    vertical: AppTheme.spacingS,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Search Icon
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
              
              // Filter Icon
              IconButton(
                icon: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ],
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
          color: isSelected ? AppTheme.primaryColor : Colors.grey[600],
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
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

  Widget _buildInventoryContent() {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        children: [
          // Inventory Cards List
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Show 3 cards as in the image
              itemBuilder: (context, index) {
                return _buildInventoryCard(index);
              },
            ),
          ),
          
          // Pagination
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildInventoryCard(int index) {
    final inventoryItems = [
      {
        'id': 'P-56165',
        'stock': '345',
        'partNumber': '6004227',
        'description': 'Velcro Loop Adhesive Back',
        'category': 'ES2-re',
        'trackable': 'No',
        'location': 'Crash Lab Rac...',
        'minQuantity': '10',
      },
      {
        'id': 'P-56167',
        'stock': '0',
        'partNumber': '6004235',
        'description': 'Velcro Loop Adhesive Back',
        'category': 'ES2-re',
        'trackable': 'No',
        'location': 'Warehouse 23A',
        'minQuantity': '20',
      },
      {
        'id': 'P-56165',
        'stock': '10',
        'partNumber': '6004227',
        'description': 'Velcro Loop A',
        'category': 'ES2-re',
        'trackable': 'No',
        'location': 'Crash Lab Rac...',
        'minQuantity': '10',
      },
    ];

    final item = inventoryItems[index];
    final isLastCard = index == 2; // Third card

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: AppCard(
        variant: AppCardVariant.elevated,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with ID and Stock
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Text(
                      item['id']!,
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    child: Text(
                      'In Stock : ${item['stock']}',
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              // Part Number and Description
              Text(
                item['partNumber']!,
                style: AppTheme.heading4.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                item['description']!,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingM),
              
              // Details Grid
              Row(
                children: [
                  // Left Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Part Category', item['category']!),
                        const SizedBox(height: AppTheme.spacingS),
                        _buildDetailRow('Trackable', item['trackable']!),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: AppTheme.spacingL),
                  
                  // Right Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Default Location', item['location']!),
                        const SizedBox(height: AppTheme.spacingS),
                        _buildDetailRow('Minimum Quantity', item['minQuantity']!),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Pagination overlay for last card
              if (isLastCard) ...[
                const SizedBox(height: AppTheme.spacingM),
                _buildPaginationOverlay(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentPage > 1 ? () {
              setState(() => _currentPage--);
            } : null,
            color: _currentPage > 1 ? AppTheme.primaryColor : Colors.grey,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingL,
              vertical: AppTheme.spacingS,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Text(
              '$_currentPage of $_totalPages Pages',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentPage < _totalPages ? () {
              setState(() => _currentPage++);
            } : null,
            color: _currentPage < _totalPages ? AppTheme.primaryColor : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationOverlay() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingL,
        vertical: AppTheme.spacingS,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$_currentPage of $_totalPages Pages',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Icon(
            Icons.play_arrow,
            color: AppTheme.primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
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
              _buildNavButton(
                asset: 'assets/icons/home.svg',
                label: 'Home',
                isSelected: false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const TitanHomePage()),
                  );
                },
              ),
              _buildNavButton(
                asset: 'assets/icons/test_request.svg',
                label: 'Test Request',
                isSelected: false,
                onTap: () {},
              ),
              _buildNavButton(
                asset: 'assets/icons/work_order.svg',
                label: 'Work Order',
                isSelected: false,
                onTap: () {},
              ),
              _buildNavButton(
                asset: 'assets/icons/test_article.svg',
                label: 'Inventory',
                isSelected: true,
                onTap: () {},
              ),
              _buildNavButton(
                asset: 'assets/icons/reporting.svg',
                label: 'Reporting',
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required String asset,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color iconColor = isSelected ? AppTheme.primaryColor : AppTheme.textSecondary;
    final TextStyle labelStyle = AppTheme.bodySmall.copyWith(
      color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
            color: isSelected ? AppTheme.primaryColor.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                asset,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(height: 4),
              Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: labelStyle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
