import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

enum AppButtonVariant { primary, secondary, outline, subtle, destructive }
enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool fullWidth;
  final IconData? icon;
  final Widget? leading;
  final Widget? trailing;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.fullWidth = true,
    this.icon,
    this.leading,
    this.trailing,
    this.borderRadius,
  });

  double get _height {
    switch (size) {
      case AppButtonSize.small:
        return 40;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 56;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: AppTheme.spacingM);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: AppTheme.spacingL);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: AppTheme.spacingXL);
    }
  }

  ButtonStyle _style(BuildContext context) {
    final radius = (borderRadius ?? BorderRadius.circular(AppTheme.radiusL));

    Color bgPrimary = AppTheme.primaryColor;
    Color fgOnPrimary = Colors.white;
    Color outline = AppTheme.primaryColor;

    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: bgPrimary,
          foregroundColor: fgOnPrimary,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
          shadowColor: bgPrimary.withOpacity(0.25),
          textStyle: AppTheme.buttonText,
        );
      case AppButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppTheme.secondaryColor,
          foregroundColor: Colors.white,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
          textStyle: AppTheme.buttonText,
        );
      case AppButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: outline,
          side: BorderSide(color: outline),
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: AppTheme.buttonText.copyWith(color: outline),
        );
      case AppButtonVariant.subtle:
        return TextButton.styleFrom(
          foregroundColor: AppTheme.textSecondary,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: AppTheme.buttonText.copyWith(color: AppTheme.textSecondary),
        );
      case AppButtonVariant.destructive:
        return ElevatedButton.styleFrom(
          backgroundColor: AppTheme.errorColor,
          foregroundColor: Colors.white,
          padding: _padding,
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
          textStyle: AppTheme.buttonText,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);
    final style = _style(context);
    final width = fullWidth ? double.infinity : null;

    final bool isDisabled = isLoading || onPressed == null;

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
      case AppButtonVariant.destructive:
        button = ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
      case AppButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
      case AppButtonVariant.subtle:
        button = TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
    }

    return SizedBox(width: width, height: _height, child: button);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    final List<Widget> children = [];

    if (leading != null) {
      children.add(leading!);
      children.add(const SizedBox(width: AppTheme.spacingS));
    } else if (icon != null) {
      children.add(Icon(icon, size: 20));
      children.add(const SizedBox(width: AppTheme.spacingS));
    }

    children.add(Text(label));

    if (trailing != null) {
      children.add(const SizedBox(width: AppTheme.spacingS));
      children.add(trailing!);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}



