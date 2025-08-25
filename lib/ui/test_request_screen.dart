import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';

class TestRequestScreen extends StatefulWidget {
  const TestRequestScreen({super.key});

  @override
  State<TestRequestScreen> createState() => _TestRequestScreenState();
}

class _TestRequestScreenState extends State<TestRequestScreen> {
  @override
  Widget build(BuildContext context) {
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
                'Test Requests',
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

              // Header Section
              AppCard(
                variant: AppCardVariant.elevated,
                padding: EdgeInsets.all(AppTheme.spacingL),
                color: AppTheme.primaryColor,
                child: Container(
                  decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Test Request Management',
                        style: AppTheme.heading3.copyWith(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingS),
                      Text(
                        'Create and manage test requests for your projects',
                        style: AppTheme.bodyLarge.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('New Test Request'),
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
                  ),
                  SizedBox(width: AppTheme.spacingM),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.surfaceColor,
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Test Requests List
              Text(
                'Recent Test Requests',
                style: AppTheme.heading4.copyWith(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: AppTheme.spacingM),

              _buildTestRequestsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestRequestsList() {
    final testRequests = [
      {
        'id': 'TR-001',
        'title': 'E-commerce App Performance Test',
        'status': 'Pending',
        'priority': 'High',
        'date': '2024-01-15',
        'assignedTo': 'John Doe',
      },
      {
        'id': 'TR-002',
        'title': 'Mobile Banking Security Test',
        'status': 'In Progress',
        'priority': 'Medium',
        'date': '2024-01-14',
        'assignedTo': 'Jane Smith',
      },
      {
        'id': 'TR-003',
        'title': 'API Integration Test',
        'status': 'Completed',
        'priority': 'Low',
        'date': '2024-01-13',
        'assignedTo': 'Mike Johnson',
      },
    ];

    return Column(
      children: testRequests.map((request) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingS,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(request['status']!).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      child: Text(
                        request['status']!,
                        style: AppTheme.bodySmall.copyWith(
                          color: _getStatusColor(request['status']!),
                          fontWeight: FontWeight.w600,
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
                        color: _getPriorityColor(request['priority']!).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      child: Text(
                        request['priority']!,
                        style: AppTheme.bodySmall.copyWith(
                          color: _getPriorityColor(request['priority']!),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingM),
                Text(
                  request['title']!,
                  style: AppTheme.heading4.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: AppTheme.spacingS),
                Text(
                  'ID: ${request['id']}',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppTheme.spacingM),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    SizedBox(width: AppTheme.spacingXS),
                    Text(
                      request['date']!,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingL),
                    Icon(
                      Icons.person,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    SizedBox(width: AppTheme.spacingXS),
                    Text(
                      request['assignedTo']!,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppTheme.warningColor;
      case 'in progress':
        return AppTheme.primaryColor;
      case 'completed':
        return AppTheme.successColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppTheme.errorColor;
      case 'medium':
        return AppTheme.warningColor;
      case 'low':
        return AppTheme.successColor;
      default:
        return AppTheme.textSecondary;
    }
  }
}
