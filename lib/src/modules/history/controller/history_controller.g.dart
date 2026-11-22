// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryController on _HistoryControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_HistoryControllerBase.isLoading');

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

  final _$errorMessageAtom = Atom(name: '_HistoryControllerBase.errorMessage');

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

  final _$historyListAtom = Atom(name: '_HistoryControllerBase.historyList');

  @override
  ObservableList<AddressModel> get historyList {
    _$historyListAtom.reportRead();
    return super.historyList;
  }

  @override
  set historyList(ObservableList<AddressModel> value) {
    _$historyListAtom.reportWrite(value, super.historyList, () {
      super.historyList = value;
    });
  }

  final _$clearHistoryAsyncAction =
      AsyncAction('_HistoryControllerBase.clearHistory');

  @override
  Future<void> clearHistory() {
    return _$clearHistoryAsyncAction.run(() => super.clearHistory());
  }

  final _$traceRouteAsyncAction =
      AsyncAction('_HistoryControllerBase.traceRoute');

  @override
  Future<void> traceRoute(AddressModel address) {
    return _$traceRouteAsyncAction.run(() => super.traceRoute(address));
  }

  final _$_HistoryControllerBaseActionController =
      ActionController(name: '_HistoryControllerBase');

  @override
  void loadHistory() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
      name: '_HistoryControllerBase.loadHistory',
    );
    try {
      return super.loadHistory();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearError() {
    final _$actionInfo = _$_HistoryControllerBaseActionController.startAction(
      name: '_HistoryControllerBase.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_HistoryControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
historyList: ${historyList}
    ''';
  }
}
