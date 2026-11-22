import 'package:flutter/material.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class AddressListComponent extends StatelessWidget {
  final List<AddressModel> addresses;
  final ValueChanged<AddressModel>? onItemTap;
  final ValueChanged<AddressModel>? onTraceRoute;
  final bool shrinkWrap;

  const AddressListComponent({
    Key? key,
    required this.addresses,
    this.onItemTap,
    this.onTraceRoute,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      itemCount: addresses.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppMetrics.spacingSM),
      itemBuilder: (context, index) {
        final item = addresses[index];
        return InkWell(
          onTap: onItemTap != null ? () => onItemTap!(item) : null,
          borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
          child: Container(
            padding: const EdgeInsets.all(AppMetrics.spacingMD),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.primary,
                  size: AppMetrics.iconMD,
                ),
                const SizedBox(width: AppMetrics.spacingSM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.displayStreet,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.displayNeighborhood} • ${item.cityState}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'CEP ${item.cep}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTraceRoute != null)
                  IconButton(
                    onPressed: () => onTraceRoute!(item),
                    tooltip: 'Traçar rota',
                    icon: const Icon(
                      Icons.directions_outlined,
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
