import 'package:flutter/material.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class LastAddressComponent extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onTraceRoute;

  const LastAddressComponent({
    Key? key,
    required this.address,
    required this.onTraceRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppMetrics.spacingMD),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
        border: Border.all(color: AppColors.primary.withOpacity(0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppMetrics.spacingSM),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppMetrics.radiusSM),
                ),
                child: const Icon(
                  Icons.place_rounded,
                  color: AppColors.primary,
                  size: AppMetrics.iconMD,
                ),
              ),
              const SizedBox(width: AppMetrics.spacingSM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Último endereço consultado',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'CEP ${address.cep}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onTraceRoute,
                tooltip: 'Traçar rota',
                icon: const Icon(
                  Icons.directions_rounded,
                  color: AppColors.accent,
                  size: 28,
                ),
              ),
            ],
          ),
          const Divider(height: AppMetrics.spacingLG),
          _buildInfoRow('Logradouro', address.displayStreet),
          const SizedBox(height: AppMetrics.spacingSM),
          _buildInfoRow('Bairro', address.displayNeighborhood),
          const SizedBox(height: AppMetrics.spacingSM),
          _buildInfoRow('Cidade / UF', address.cityState),
          if (address.complemento.isNotEmpty) ...[
            const SizedBox(height: AppMetrics.spacingSM),
            _buildInfoRow('Complemento', address.complemento),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
