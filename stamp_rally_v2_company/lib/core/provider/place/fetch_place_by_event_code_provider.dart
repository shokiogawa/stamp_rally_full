import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/repository/csv.repository.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/service/utility/get_holiday_jp.servce.dart';
part 'fetch_place_by_event_code_provider.g.dart';

// スポット一覧データ取得
@Riverpod(keepAlive: true)
Future<List<PlaceModel>> fetchPlaceByEventCode(
    Ref ref, String eventCode) async {
  try {
    // csvからイベント一覧デーを取得
    final csvRepo = ref.read(csvRepositoryProvider);
    final placeList = await csvRepo.fetchPlaceByEventCode(eventCode);

    final jpHolidays =
        await ref.read(getHolidayJpServiceProvider).getHolidays();

    return placeList
        .map((o) => PlaceModel.fromAsset(data: o, jpHoliday: jpHolidays))
        .toList();
  } catch (e) {
    rethrow;
  }
}
