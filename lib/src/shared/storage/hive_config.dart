import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class HiveConfig {
  HiveConfig._();

  static const String addressBoxName = 'fast_location_addresses';

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    final storagePath = p.join(appDir.path, 'fast_location_db');

    await Hive.initFlutter(storagePath);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AddressModelAdapter());
    }

    await Hive.openBox<AddressModel>(addressBoxName);
  }

  static Box<AddressModel> get addressBox =>
      Hive.box<AddressModel>(addressBoxName);
}
