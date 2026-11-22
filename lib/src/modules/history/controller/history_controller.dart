import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/home_service.dart';

part 'history_controller.g.dart';

class HistoryController = _HistoryControllerBase with _$HistoryController;

abstract class _HistoryControllerBase with Store {
  final HomeService _service;

  _HistoryControllerBase({HomeService? service})
      : _service = service ?? HomeService();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  ObservableList<AddressModel> historyList = ObservableList<AddressModel>();

  @action
  void loadHistory() {
    isLoading = true;
    errorMessage = null;

    try {
      final items = _service.getHistory();
      historyList = ObservableList<AddressModel>.of(items);
    } catch (_) {
      errorMessage = 'Não foi possível carregar o histórico local.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> clearHistory() async {
    await _service.clearHistory();
    historyList.clear();
  }

  @action
  Future<void> traceRoute(AddressModel address) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _service.openRouteToAddress(address);
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  @action
  void clearError() {
    errorMessage = null;
  }
}
