import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/@common/csv_model.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

part 'csv.service.g.dart';

@Riverpod(keepAlive: true)
CsvService csvService(Ref ref) {
  return CsvService();
}

class CsvService {
  // csvからデータ取得し、csvmodelに変換する
  Future<CsvModel?> getCsvToCsvModel({required String url}) async {
    try {
      final response = await http.get(Uri.parse(url));
      const d = FirstOccurrenceSettingsDetector(eols: ['\r\n', '\n']);
      final table = const CsvToListConverter(csvSettingsDetector: d)
          .convert(utf8.decode(response.body.runes.toList()));
      return CsvModel(
        columnNames: table.first.map((e) => e.toString()).toList(),
        rows: table.sublist(1),
      );
    } catch (e, st) {
      logger.e(
        'Failed to get CSV data from asset: $url',
        error: e,
        stackTrace: st,
      );
    }
    return null;
  }

  // csvmodelをjsonに変換する
  Future<List<Map<String, dynamic>>?> convertCsvToJson(
      {required String url}) async {
    try {
      final csv = await getCsvToCsvModel(url: url);
      if (csv == null) {
        logger.w('CSV data is null, cannot convert to JSON');
        return null;
      }
      final str = jsonEncode(csv.rows
          .map((rows) => Map.fromIterables(csv.columnNames, rows))
          .toList());
      return List<Map<String, dynamic>>.from(
          jsonDecode(str).map((e) => Map<String, dynamic>.from(e)));
    } catch (e, st) {
      logger.e(
        'Failed to convert CSV to JSON',
        error: e,
        stackTrace: st,
      );
    }
    return null;
  }

  // csvデータからjsonに変換する
  Future<List<T>?> fetchData<T>({required String url}) async {
    try {
      final jsonList = await convertCsvToJson(url: url);
      if (jsonList == null) {
        logger.w('JSON data is null, cannot convert to type $T');
        return null;
      }

      // データが存在しない場合は、削除
      jsonList.removeWhere(
          (element) => (element['historicSpotId'] as String).isEmpty);

      return jsonList.map((json) => T.fromJson(json) as T).toList();
    } catch (e, st) {
      logger.e(
        'Failed to fetch data and convert to type $T',
        error: e,
        stackTrace: st,
      );
    }
    return null;
  }
}

extension on Type {
  fromJson(Map<String, dynamic> json) {}
}
