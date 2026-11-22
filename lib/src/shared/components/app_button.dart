import 'package:flutter/material.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool outlined;
  final Color? color;

  const AppButton({
    Key? key,
    required this.label,
    this.icon,
    this.onPressed,
    this.outlined = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    if (outlined) {
      return SizedBox(
        width: double.infinity,
        height: AppMetrics.buttonHeight,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, size: AppMetrics.iconSM, color: buttonColor)
              : const SizedBox.shrink(),
          label: Text(
            label,
            style: TextStyle(
              color: buttonColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: buttonColor, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: AppMetrics.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, size: AppMetrics.iconSM, color: AppColors.white)
            : const SizedBox.shrink(),
        label: Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
          ),
        ),
      ),
    );
  }
}
