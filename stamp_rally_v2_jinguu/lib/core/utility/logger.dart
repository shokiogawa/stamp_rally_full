import 'package:logger/logger.dart';

late final Logger _logger;
Logger get logger => _logger;

class LoggerClass {
  // プライベートコンストラクト
  LoggerClass._();
  static void configure() {
    _logger = Logger(printer: PrettyPrinter());
    // _logger = SimpleLogger()
    //   ..setLevel(
    //     kDebugMode ? Level.FINE : Level.OFF,
    //     includeCallerInfo: kDebugMode,
    //   );
  }
}

// logger.v('Hello logger!');
// logger.d(1000);
// logger.i(true);
// logger.w([1, 2, 3]);
// logger.e({'key': 'key', 'value': 'value'});
// logger.wtf(Exception('例外もいけます'));
// logger.i(() => '関数もいけます');
