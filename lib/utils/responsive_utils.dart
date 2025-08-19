import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppTheme.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppTheme.mobileBreakpoint &&
           MediaQuery.of(context).size.width < AppTheme.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppTheme.desktopBreakpoint;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return AppTheme.spacingM;
    } else if (isTablet(context)) {
      return AppTheme.spacingL;
    } else {
      return AppTheme.spacingXL;
    }
  }

  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else {
      return baseSize * 1.2;
    }
  }

  static EdgeInsets getResponsivePaddingAll(BuildContext context) {
    double padding = getResponsivePadding(context);
    return EdgeInsets.all(padding);
  }

  static EdgeInsets getHorizontalPadding(BuildContext context) {
    double padding = getResponsivePadding(context);
    return EdgeInsets.symmetric(horizontal: padding);
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) {
      return getScreenWidth(context);
    } else if (isTablet(context)) {
      return 600;
    } else {
      return 800;
    }
  }

  static Widget responsiveBuilder({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }

  static List<Widget> responsiveChildren({
    required BuildContext context,
    required List<Widget> children,
    int? maxChildrenPerRow,
  }) {
    if (maxChildrenPerRow == null) {
      if (isMobile(context)) {
        maxChildrenPerRow = 1;
      } else if (isTablet(context)) {
        maxChildrenPerRow = 2;
      } else {
        maxChildrenPerRow = 3;
      }
    }

    List<Widget> result = [];
    for (int i = 0; i < children.length; i += maxChildrenPerRow) {
      int end = (i + maxChildrenPerRow < children.length) 
          ? i + maxChildrenPerRow 
          : children.length;
      result.add(
        Row(
          children: children.sublist(i, end).map((child) {
            return Expanded(child: child);
          }).toList(),
        ),
      );
    }
    return result;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveUtils.responsiveBuilder(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? ResponsiveUtils.getMaxContentWidth(context),
        ),
        padding: padding ?? ResponsiveUtils.getHorizontalPadding(context),
        child: child,
      ),
    );
  }
} 