import 'package:mobx/mobx.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/modules/home/service/home_service.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final HomeService _service;

  _HomeControllerBase({HomeService? service})
      : _service = service ?? HomeService();

  @observable
  bool isLoading = false;

  @observable
  bool notFound = false;

  @observable
  String? errorMessage;

  @observable
  AddressModel? lastAddress;

  @observable
  ObservableList<AddressModel> recentAddresses = ObservableList<AddressModel>();

  @observable
  ObservableList<AddressModel> searchResults = ObservableList<AddressModel>();

  @action
  void loadInitialData() {
    lastAddress = _service.getLastAddress();
    recentAddresses = ObservableList<AddressModel>.of(_service.getHistory());
  }

  @action
  void clearError() {
    errorMessage = null;
  }

  @action
  void clearSearchResults() {
    searchResults.clear();
  }

  @action
  Future<bool> searchByCep(String cep) async {
    isLoading = true;
    notFound = false;
    errorMessage = null;
    searchResults.clear();

    try {
      final result = await _service.consultByCep(cep);
      if (result == null) {
        notFound = true;
        return false;
      }

      loadInitialData();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> searchByAddress({
    required String uf,
    required String city,
    required String street,
  }) async {
    isLoading = true;
    notFound = false;
    errorMessage = null;
    searchResults.clear();

    try {
      final results = await _service.consultByAddress(
        uf: uf,
        city: city,
        street: street,
      );

      if (results.isEmpty) {
        notFound = true;
      } else {
        searchResults = ObservableList<AddressModel>.of(results);
      }
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> selectAddress(AddressModel address) async {
    await _service.saveSelectedAddress(address);
    notFound = false;
    searchResults.clear();
    loadInitialData();
  }

  @action
  Future<void> traceRouteToLastAddress() async {
    if (lastAddress == null) {
      errorMessage = 'Consulte um endereço antes de traçar uma rota.';
      return;
    }

    await traceRoute(lastAddress!);
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
}
