import 'package:flutter/material.dart';
import 'package:fast_location/src/app.dart';
import 'package:fast_location/src/shared/storage/hive_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  runApp(const FastLocationApp());
}
