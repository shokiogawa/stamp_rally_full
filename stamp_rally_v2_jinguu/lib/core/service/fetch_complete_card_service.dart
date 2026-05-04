import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/complete_card/model/complete_card_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/service/csv.service.dart';

part 'fetch_complete_card_service.g.dart';

@riverpod
FetchCompleteCardService fetchCompleteCardService(Ref ref) {
  final csvService = ref.read(csvServiceProvider);
  return FetchCompleteCardService(csvService);
}

class FetchCompleteCardService {
  final CsvService csvService;
  FetchCompleteCardService(this.csvService);

  Future<CompleteCardModel?> execute(String url) async {
    final json = await csvService.convertCsvToJson(url: url);
    if (json == null) {
      return null;
    }

    final dataList = json.map((o) => CompleteCardModel.fromJson(o)).toList();
    return dataList[0];
  }
}
