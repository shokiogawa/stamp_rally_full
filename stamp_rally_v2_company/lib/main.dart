import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/configuration/configuration.dart';
import 'package:stamp_rally_v2_fvm/configuration/flavor.dart';
import 'package:stamp_rally_v2_fvm/core/database_provider.dart';
import 'package:stamp_rally_v2_fvm/core/setup/database.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

import 'app.dart';

Future<void> main() async {
  // Flutterの初期化を行う
  WidgetsFlutterBinding.ensureInitialized();
  final flavor =
      FlavorType.getFromString(const String.fromEnvironment('flavor'));

  Configuration.setup(flavor: flavor);
  LoggerClass.configure();

  final database = await DatabaseHelper.init();

  logger.i("アプリスタート in $flavor");

  // アプリスタート
  runApp(ProviderScope(overrides: [
    databaseProvider.overrideWithValue(database),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
