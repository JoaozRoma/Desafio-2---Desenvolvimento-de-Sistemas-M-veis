// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_HomeControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$notFoundAtom = Atom(name: '_HomeControllerBase.notFound');

  @override
  bool get notFound {
    _$notFoundAtom.reportRead();
    return super.notFound;
  }

  @override
  set notFound(bool value) {
    _$notFoundAtom.reportWrite(value, super.notFound, () {
      super.notFound = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_HomeControllerBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$lastAddressAtom = Atom(name: '_HomeControllerBase.lastAddress');

  @override
  AddressModel? get lastAddress {
    _$lastAddressAtom.reportRead();
    return super.lastAddress;
  }

  @override
  set lastAddress(AddressModel? value) {
    _$lastAddressAtom.reportWrite(value, super.lastAddress, () {
      super.lastAddress = value;
    });
  }

  final _$recentAddressesAtom =
      Atom(name: '_HomeControllerBase.recentAddresses');

  @override
  ObservableList<AddressModel> get recentAddresses {
    _$recentAddressesAtom.reportRead();
    return super.recentAddresses;
  }

  @override
  set recentAddresses(ObservableList<AddressModel> value) {
    _$recentAddressesAtom.reportWrite(value, super.recentAddresses, () {
      super.recentAddresses = value;
    });
  }

  final _$searchResultsAtom = Atom(name: '_HomeControllerBase.searchResults');

  @override
  ObservableList<AddressModel> get searchResults {
    _$searchResultsAtom.reportRead();
    return super.searchResults;
  }

  @override
  set searchResults(ObservableList<AddressModel> value) {
    _$searchResultsAtom.reportWrite(value, super.searchResults, () {
      super.searchResults = value;
    });
  }

  final _$searchByCepAsyncAction =
      AsyncAction('_HomeControllerBase.searchByCep');

  @override
  Future<bool> searchByCep(String cep) {
    return _$searchByCepAsyncAction.run(() => super.searchByCep(cep));
  }

  final _$searchByAddressAsyncAction =
      AsyncAction('_HomeControllerBase.searchByAddress');

  @override
  Future<void> searchByAddress({
    required String uf,
    required String city,
    required String street,
  }) {
    return _$searchByAddressAsyncAction.run(
      () => super.searchByAddress(uf: uf, city: city, street: street),
    );
  }

  final _$selectAddressAsyncAction =
      AsyncAction('_HomeControllerBase.selectAddress');

  @override
  Future<void> selectAddress(AddressModel address) {
    return _$selectAddressAsyncAction.run(() => super.selectAddress(address));
  }

  final _$traceRouteToLastAddressAsyncAction =
      AsyncAction('_HomeControllerBase.traceRouteToLastAddress');

  @override
  Future<void> traceRouteToLastAddress() {
    return _$traceRouteToLastAddressAsyncAction
        .run(() => super.traceRouteToLastAddress());
  }

  final _$traceRouteAsyncAction =
      AsyncAction('_HomeControllerBase.traceRoute');

  @override
  Future<void> traceRoute(AddressModel address) {
    return _$traceRouteAsyncAction.run(() => super.traceRoute(address));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void loadInitialData() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
      name: '_HomeControllerBase.loadInitialData',
    );
    try {
      return super.loadInitialData();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
      name: '_HomeControllerBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearSearchResults() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
      name: '_HomeControllerBase.clearSearchResults',
    );
    try {
      return super.clearSearchResults();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
notFound: ${notFound},
errorMessage: ${errorMessage},
lastAddress: ${lastAddress},
recentAddresses: ${recentAddresses},
searchResults: ${searchResults}
    ''';
  }
}
