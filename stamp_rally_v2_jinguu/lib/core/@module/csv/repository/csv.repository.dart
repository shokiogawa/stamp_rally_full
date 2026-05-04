import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/configuration/configuration.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/service/csv.service.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_csv_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_csv_model.dart';

part 'csv.repository.g.dart';

@riverpod
CsvRepository csvRepository(Ref ref) {
  final csvService = ref.read(csvServiceProvider);
  return CsvRepository(csvService);
}

class CsvRepository {
  final CsvService csvService;
  CsvRepository(this.csvService);

  late final eventListCsv = Configuration.instance.eventListCsv;

  // イベント一覧データ取得
  Future<List<StampRallyEventCsvModel>?> fetchStampRallyEventCsvList() async {
    final json = await csvService.convertCsvToJson(url: eventListCsv);
    if (json == null) {
      return null;
    }

    final dataList =
        json.map((o) => StampRallyEventCsvModel.fromJson(o)).toList();
    return dataList;
  }

  // eventコードの場所一覧を取得する
  Future<List<PlaceCsvModel>> fetchPlaceByEventCode(String eventCode) async {
    try {
      // csvからイベント一覧デーを取得
      final eventModel = await fetchStampRallyEventCsvList();
      if (eventModel == null) {
        return [];
      }

      // url特定
      final url = eventModel
              .firstWhereOrNull((v) => v.code == eventCode)
              ?.placeDataListCsv ??
          '';

      // csvからデータを取得
      final json = await csvService.convertCsvToJson(url: url);
      if (json == null) {
        return [];
      }

      // final jpHolidays = await getHolidays();

      // データが存在しない場合は、削除
      json.removeWhere(
          (element) => (element['historicSpotId'] as String).isEmpty);

      return json.map((o) => PlaceCsvModel.fromJson(o)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Future<List<DateTime>> getHolidays() async {
  //   const String url = 'https://holidays-jp.github.io/api/v1/date.json';

  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     return data.keys.map((key) => DateTime.parse(key)).toList();
  //   } else {
  //     throw Exception('Failed to load holidays');
  //   }
  // }
}
