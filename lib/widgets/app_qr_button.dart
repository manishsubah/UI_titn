import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class AppQrButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const AppQrButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                ),
              )
            : Icon(
                icon ?? Icons.qr_code_scanner,
                size: 20,
                color: AppTheme.textPrimary,
              ),
        label: Text(
          label,
          style: AppTheme.buttonText.copyWith(
            color: AppTheme.textPrimary,
            fontSize: 16,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.textPrimary,
          side: const BorderSide(color: AppTheme.borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusL),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

