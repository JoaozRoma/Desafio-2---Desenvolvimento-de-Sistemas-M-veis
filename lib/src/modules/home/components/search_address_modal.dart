import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/src/modules/home/components/address_list_component.dart';
import 'package:fast_location/src/modules/home/components/empty_search_component.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/components/app_button.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class SearchAddressModal extends StatefulWidget {
  final HomeController controller;

  const SearchAddressModal({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SearchAddressModal> createState() => _SearchAddressModalState();
}

class _SearchAddressModalState extends State<SearchAddressModal>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    widget.controller.clearSearchResults();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cepController.dispose();
    _ufController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  Future<void> _submitCep() async {
    FocusScope.of(context).unfocus();
    final found = await widget.controller.searchByCep(_cepController.text);
    if (found && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _submitAddress() async {
    FocusScope.of(context).unfocus();
    await widget.controller.searchByAddress(
      uf: _ufController.text,
      city: _cityController.text,
      street: _streetController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.82,
        ),
        padding: const EdgeInsets.all(AppMetrics.spacingMD),
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppMetrics.radiusLG),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppMetrics.spacingMD),
            const Text(
              'Nova Consulta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppMetrics.spacingSM),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Buscar por CEP'),
                Tab(text: 'Buscar por Endereço'),
              ],
            ),
            const SizedBox(height: AppMetrics.spacingMD),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCepTab(),
                  _buildAddressTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCepTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _cepController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
            ],
            decoration: InputDecoration(
              labelText: 'Digite o CEP',
              hintText: 'Ex: 89010000',
              prefixIcon: const Icon(Icons.pin_drop_outlined),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
              ),
            ),
            onSubmitted: (_) => _submitCep(),
          ),
          const SizedBox(height: AppMetrics.spacingMD),
          Observer(
            builder: (_) => AppButton(
              label: widget.controller.isLoading
                  ? 'Consultando...'
                  : 'Consultar CEP',
              icon: Icons.search_rounded,
              onPressed: widget.controller.isLoading ? null : _submitCep,
            ),
          ),
          const SizedBox(height: AppMetrics.spacingMD),
          Observer(
            builder: (_) {
              if (!widget.controller.notFound) {
                return const SizedBox.shrink();
              }
              return const EmptySearchComponent(
                title: 'CEP não encontrado',
                subtitle:
                    'Confira os 8 dígitos informados ou tente buscar pelo nome da rua.',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SizedBox(
                width: 90,
                child: TextField(
                  controller: _ufController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                  ],
                  decoration: InputDecoration(
                    labelText: 'UF',
                    hintText: 'SC',
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppMetrics.spacingSM),
              Expanded(
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Cidade',
                    hintText: 'Ex: Blumenau',
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppMetrics.spacingSM),
          TextField(
            controller: _streetController,
            decoration: InputDecoration(
              labelText: 'Logradouro (completo ou parcial)',
              hintText: 'Ex: XV de Novembro',
              prefixIcon: const Icon(Icons.signpost_outlined),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppMetrics.radiusMD),
              ),
            ),
            onSubmitted: (_) => _submitAddress(),
          ),
          const SizedBox(height: AppMetrics.spacingMD),
          Observer(
            builder: (_) => AppButton(
              label: widget.controller.isLoading
                  ? 'Buscando...'
                  : 'Buscar CEP pelo Endereço',
              icon: Icons.travel_explore_rounded,
              onPressed: widget.controller.isLoading ? null : _submitAddress,
            ),
          ),
          const SizedBox(height: AppMetrics.spacingMD),
          Observer(
            builder: (_) {
              if (widget.controller.isLoading) {
                return const Padding(
                  padding: EdgeInsets.all(AppMetrics.spacingMD),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (widget.controller.notFound) {
                return const EmptySearchComponent(
                  title: 'Nenhum endereço localizado',
                  subtitle:
                      'Tente informar menos palavras do logradouro ou verifique a grafia da cidade.',
                );
              }

              if (widget.controller.searchResults.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selecione um resultado (${widget.controller.searchResults.length}):',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppMetrics.spacingSM),
                  AddressListComponent(
                    addresses: widget.controller.searchResults.toList(),
                    shrinkWrap: true,
                    onItemTap: (selected) async {
                      await widget.controller.selectAddress(selected);
                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
