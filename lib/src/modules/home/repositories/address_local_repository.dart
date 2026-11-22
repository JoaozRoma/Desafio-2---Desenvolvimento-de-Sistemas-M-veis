import 'package:hive/hive.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:fast_location/src/shared/storage/hive_config.dart';

class AddressLocalRepository {
  Box<AddressModel> get _box => HiveConfig.addressBox;

  Future<void> saveAddress(AddressModel address) async {
    final normalizedCep = address.cleanCep;

    // Remove ocorrencia anterior do mesmo CEP para manter a mais recente no topo
    dynamic existingKey;
    for (final key in _box.keys) {
      final item = _box.get(key);
      if (item != null && item.cleanCep == normalizedCep) {
        existingKey = key;
        break;
      }
    }

    if (existingKey != null) {
      await _box.delete(existingKey);
    }

    await _box.add(address.copyWith(consultedAt: DateTime.now()));
  }

  AddressModel? findByCep(String cleanCep) {
    for (final item in _box.values) {
      if (item.cleanCep == cleanCep) {
        return item;
      }
    }
    return null;
  }

  List<AddressModel> getAllAddresses() {
    return _box.values.toList().reversed.toList();
  }

  AddressModel? getLastAddress() {
    if (_box.isEmpty) return null;
    return _box.values.last;
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
