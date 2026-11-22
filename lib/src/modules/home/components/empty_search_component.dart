import 'package:flutter/material.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class EmptySearchComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptySearchComponent({
    Key? key,
    this.title = 'Nenhum endereço encontrado',
    this.subtitle =
        'Faça uma busca por CEP ou endereço para visualizar os detalhes aqui.',
    this.icon = Icons.location_off_outlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppMetrics.spacingLG),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppMetrics.iconLG,
            color: AppColors.textSecondary.withOpacity(0.6),
          ),
          const SizedBox(height: AppMetrics.spacingSM),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppMetrics.spacingXS),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
