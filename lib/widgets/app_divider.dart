import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AppDivider extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? thickness;

  const AppDivider({
    super.key,
    this.text,
    this.color,
    this.thickness,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Divider(
        color: color ?? AppTheme.borderColor,
        thickness: thickness ?? 1,
      );
    }

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: color ?? AppTheme.borderColor,
            thickness: thickness ?? 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
          child: Text(
            text!,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: color ?? AppTheme.borderColor,
            thickness: thickness ?? 1,
          ),
        ),
      ],
    );
  }
}

