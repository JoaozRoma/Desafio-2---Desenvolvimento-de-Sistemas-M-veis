import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/components/address_list_component.dart';
import 'package:fast_location/src/modules/home/components/empty_search_component.dart';
import 'package:fast_location/src/modules/home/components/last_address_component.dart';
import 'package:fast_location/src/modules/home/components/search_address_modal.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:fast_location/src/routes/app_routes.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/components/app_button.dart';
import 'package:fast_location/src/shared/components/app_loading.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  late final ReactionDisposer _errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    _controller.loadInitialData();

    // Reacao do MobX para exibir erros de consulta ou tracado de rota
    _errorReactionDisposer = reaction<String?>(
      (_) => _controller.errorMessage,
      (message) {
        if (message != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
          _controller.clearError();
        }
      },
    );
  }

  @override
  void dispose() {
    _errorReactionDisposer();
    super.dispose();
  }

  void _openSearchModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SearchAddressModal(controller: _controller),
    );
  }

  Future<void> _openHistoryPage() async {
    await Navigator.of(context).pushNamed(AppRoutes.history);
    if (mounted) {
      _controller.loadInitialData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FastLocation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _openHistoryPage,
            tooltip: 'Histórico de consultas',
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Observer(
            builder: (_) {
              final lastAddress = _controller.lastAddress;
              final recentList = _controller.recentAddresses.take(5).toList();

              return RefreshIndicator(
                onRefresh: () async => _controller.loadInitialData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(AppMetrics.spacingMD),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        label: 'Localizar endereço',
                        icon: Icons.search_rounded,
                        onPressed: _openSearchModal,
                      ),
                      const SizedBox(height: AppMetrics.spacingMD),
                      if (lastAddress != null) ...[
                        LastAddressComponent(
                          address: lastAddress,
                          onTraceRoute: _controller.traceRouteToLastAddress,
                        ),
                        const SizedBox(height: AppMetrics.spacingSM),
                        AppButton(
                          label: 'Traçar rota para o último endereço',
                          icon: Icons.directions_rounded,
                          color: AppColors.accent,
                          onPressed: _controller.traceRouteToLastAddress,
                        ),
                      ] else
                        const EmptySearchComponent(
                          title: 'Nenhuma consulta realizada',
                          subtitle:
                              'Toque em "Localizar endereço" para pesquisar por CEP ou nome da rua.',
                          icon: Icons.map_outlined,
                        ),
                      const SizedBox(height: AppMetrics.spacingLG),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Consultas recentes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _openHistoryPage,
                            icon: const Icon(Icons.history_rounded, size: 18),
                            label: const Text('Ver histórico'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppMetrics.spacingSM),
                      if (recentList.isEmpty)
                        const EmptySearchComponent(
                          title: 'Histórico vazio',
                          subtitle:
                              'Os endereços consultados ficam salvos aqui para acesso rápido.',
                          icon: Icons.history_toggle_off_rounded,
                        )
                      else
                        AddressListComponent(
                          addresses: recentList,
                          shrinkWrap: true,
                          onItemTap: (address) =>
                              _controller.selectAddress(address),
                          onTraceRoute: (address) =>
                              _controller.traceRoute(address),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          Observer(
            builder: (_) => _controller.isLoading
                ? const AppLoading()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
