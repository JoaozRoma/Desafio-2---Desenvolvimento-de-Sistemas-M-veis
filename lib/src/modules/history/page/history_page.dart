import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/history/controller/history_controller.dart';
import 'package:fast_location/src/modules/home/components/address_list_component.dart';
import 'package:fast_location/src/modules/home/components/empty_search_component.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/components/app_loading.dart';
import 'package:fast_location/src/shared/metrics/app_metrics.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController();
  late final ReactionDisposer _errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    _controller.loadHistory();

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

  Future<void> _confirmClearHistory() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar histórico'),
        content: const Text(
          'Deseja remover todos os endereços salvos no dispositivo?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Limpar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _controller.clearHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Consultas'),
        actions: [
          Observer(
            builder: (_) {
              if (_controller.historyList.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                onPressed: _confirmClearHistory,
                tooltip: 'Limpar histórico',
                icon: const Icon(Icons.delete_outline_rounded),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppMetrics.spacingMD),
            child: Observer(
              builder: (_) {
                if (_controller.historyList.isEmpty) {
                  return const Center(
                    child: EmptySearchComponent(
                      title: 'Nenhum endereço no histórico',
                      subtitle:
                          'Assim que você consultar CEPs na tela inicial, eles aparecerão listados aqui.',
                      icon: Icons.history_rounded,
                    ),
                  );
                }

                return AddressListComponent(
                  addresses: _controller.historyList.toList(),
                  onTraceRoute: (address) => _controller.traceRoute(address),
                );
              },
            ),
          ),
          Observer(
            builder: (_) => _controller.isLoading
                ? const AppLoading(message: 'Abrindo rota...')
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
