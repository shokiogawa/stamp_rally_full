import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/service/csv.service.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_csv_model.dart';

part 'fetch_stamp_rally_event_list_service.g.dart';

@riverpod
FetchStampRallyEventListService fetchStampRallyEventListService(Ref ref) {
  final csvService = ref.read(csvServiceProvider);
  return FetchStampRallyEventListService(csvService);
}

class FetchStampRallyEventListService {
  final CsvService csvService;
  FetchStampRallyEventListService(this.csvService);

  Future<List<StampRallyEventCsvModel>?> execute() async {
    const url = 'https://jinja-net.jp/data/stamp_rally_event_list.csv';
    final json = await csvService.convertCsvToJson(url: url);
    if (json == null) {
      return null;
    }

    final dataList =
        json.map((o) => StampRallyEventCsvModel.fromJson(o)).toList();
    return dataList;
  }
}
