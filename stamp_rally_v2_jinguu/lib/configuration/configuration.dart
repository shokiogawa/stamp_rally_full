import 'package:flutter/foundation.dart';
import 'package:stamp_rally_v2_fvm/configuration/develop/config_develop.dart';
import 'package:stamp_rally_v2_fvm/configuration/flavor.dart';
import 'package:stamp_rally_v2_fvm/configuration/production/config_production.dart';

class Configuration {
  static Configuration? _instance;

  static Configuration get instance {
    if (_instance == null) {
      throw Exception(
          'Configuration not set. You need to call `setup` before using it.');
    }
    return _instance!;
  }

  Configuration({required this.flavor});

  final FlavorType flavor;

  bool get releaseMode => kReleaseMode && flavor == FlavorType.production;

  // int get validMeter => switch (flavor) {
  //       Flavor.develop => ConfigDevelop.validMeter,
  //       Flavor.production => ConfigProduction.validMeter,
  //     };

  String get assetHostUrl => switch (flavor) {
        FlavorType.develop => ConfigDevelop.assetHostUrl,
        FlavorType.production => ConfigProduction.assetHostUrl,
      };

  String get eventListCsv => switch (flavor) {
        FlavorType.develop => ConfigDevelop.eventListCsv,
        FlavorType.production => ConfigProduction.eventListCsv,
      };

  static Future<void> setup({required FlavorType flavor}) async {
    _instance = Configuration(flavor: flavor);
  }
}
