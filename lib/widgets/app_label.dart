import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const AppLabel({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTheme.bodySmall.copyWith(
        color: color ?? AppTheme.textSecondary,
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      textAlign: textAlign,
    );
  }
}

