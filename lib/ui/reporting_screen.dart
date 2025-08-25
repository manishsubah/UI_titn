import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_theme.dart';
import '../utils/responsive_utils.dart';
import '../widgets/app_card.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
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
                'Reporting',
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
                        'Analytics & Reporting',
                        style: AppTheme.heading3.copyWith(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingS),
                      Text(
                        'Generate comprehensive reports and analytics for your testing projects',
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
                      icon: const Icon(Icons.assessment),
                      label: const Text('Generate Report'),
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
                    icon: const Icon(Icons.download),
                    style: IconButton.styleFrom(
                      backgroundColor: AppTheme.surfaceColor,
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Analytics Overview
              Text(
                'Analytics Overview',
                style: AppTheme.heading4.copyWith(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: AppTheme.spacingM),

              _buildAnalyticsGrid(),

              SizedBox(height: AppTheme.spacingXL),

              // Recent Reports
              Text(
                'Recent Reports',
                style: AppTheme.heading4.copyWith(
                  fontSize: ResponsiveUtils.getResponsiveFontSize(context, 18),
                ),
              ),
              SizedBox(height: AppTheme.spacingM),

              _buildReportsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsGrid() {
    final analytics = [
      {
        'title': 'Total Tests',
        'value': '1,234',
        'change': '+12%',
        'icon': Icons.analytics,
        'color': AppTheme.primaryColor,
      },
      {
        'title': 'Success Rate',
        'value': '98.5%',
        'change': '+2.1%',
        'icon': Icons.trending_up,
        'color': AppTheme.successColor,
      },
      {
        'title': 'Failed Tests',
        'value': '18',
        'change': '-5%',
        'icon': Icons.error_outline,
        'color': AppTheme.errorColor,
      },
      {
        'title': 'Avg. Duration',
        'value': '2.5h',
        'change': '-0.3h',
        'icon': Icons.timer,
        'color': AppTheme.warningColor,
      },
    ];

    return ResponsiveLayout(
      mobile: _buildAnalyticsGridLayout(analytics, 2),
      tablet: _buildAnalyticsGridLayout(analytics, 4),
      desktop: _buildAnalyticsGridLayout(analytics, 4),
    );
  }

  Widget _buildAnalyticsGridLayout(List<Map<String, dynamic>> analytics, int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppTheme.spacingM,
        mainAxisSpacing: AppTheme.spacingM,
        childAspectRatio: 1.5,
      ),
      itemCount: analytics.length,
      itemBuilder: (context, index) {
        final item = analytics[index];
        return AppCard(
          variant: AppCardVariant.elevated,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingS),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusM),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      ),
                      child: Text(
                        item['change']!,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingM),
                Text(
                  item['value']!,
                  style: AppTheme.heading3.copyWith(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item['title']!,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportsList() {
    final reports = [
      {
        'id': 'RPT-001',
        'title': 'Monthly Test Performance Report',
        'type': 'Performance',
        'date': '2024-01-15',
        'status': 'Generated',
        'size': '2.5 MB',
      },
      {
        'id': 'RPT-002',
        'title': 'Security Testing Summary',
        'type': 'Security',
        'date': '2024-01-14',
        'status': 'Generated',
        'size': '1.8 MB',
      },
      {
        'id': 'RPT-003',
        'title': 'API Testing Results',
        'type': 'API',
        'date': '2024-01-13',
        'status': 'Pending',
        'size': '--',
      },
    ];

    return Column(
      children: reports.map((report) {
        return AppCard(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  decoration: BoxDecoration(
                    color: _getReportTypeColor(report['type']!).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                  child: Icon(
                    Icons.description,
                    color: _getReportTypeColor(report['type']!),
                    size: 24,
                  ),
                ),
                SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['title']!,
                        style: AppTheme.heading4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingXS),
                      Text(
                        'ID: ${report['id']} • ${report['type']}',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingXS),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          SizedBox(width: AppTheme.spacingXS),
                          Text(
                            report['date']!,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          SizedBox(width: AppTheme.spacingM),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingS,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(report['status']!).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusS),
                            ),
                            child: Text(
                              report['status']!,
                              style: AppTheme.bodySmall.copyWith(
                                color: _getStatusColor(report['status']!),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      report['size']!,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingS),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      style: IconButton.styleFrom(
                        backgroundColor: AppTheme.surfaceColor,
                        padding: const EdgeInsets.all(AppTheme.spacingS),
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

  Color _getReportTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'performance':
        return AppTheme.primaryColor;
      case 'security':
        return AppTheme.errorColor;
      case 'api':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'generated':
        return AppTheme.successColor;
      case 'pending':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondary;
    }
  }
}
