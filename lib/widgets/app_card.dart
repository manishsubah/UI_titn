import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

enum AppCardVariant { elevated, outlined, filled }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final AppCardVariant variant;
  final Color? color;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.variant = AppCardVariant.outlined,
    this.color,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? BorderRadius.circular(AppTheme.radiusL);

    BoxDecoration decoration;
    switch (variant) {
      case AppCardVariant.elevated:
        decoration = BoxDecoration(
          color: color ?? AppTheme.surfaceColor,
          borderRadius: radius,
          boxShadow: AppTheme.shadowS,
          border: Border.all(color: AppTheme.borderLight),
        );
        break;
      case AppCardVariant.outlined:
        decoration = BoxDecoration(
          color: color ?? AppTheme.surfaceColor,
          borderRadius: radius,
          border: Border.all(color: AppTheme.borderLight),
        );
        break;
      case AppCardVariant.filled:
        decoration = BoxDecoration(
          color: color ?? AppTheme.cardColor,
          borderRadius: radius,
        );
        break;
    }

    final content = Container(
      margin: margin ?? const EdgeInsets.all(AppTheme.spacingS),
      padding: padding ?? const EdgeInsets.all(AppTheme.spacingM),
      decoration: decoration,
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: content,
      ),
    );
  }
}



