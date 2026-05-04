import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/repository/csv.repository.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp/repository/stamp_repository.dart';
import 'package:stamp_rally_v2_fvm/core/service/utility/get_holiday_jp.servce.dart';

part 'place_and_stamped.service.g.dart';

@riverpod
PlaceAndStampedServce placeAndStampedServce(Ref ref) {
  final stampRepository = ref.read(stampRepositoryProvider);
  return PlaceAndStampedServce(ref, stampRepository);
}

class PlaceAndStampedServce {
  final Ref ref;
  final StampRepository stampRepository;
  const PlaceAndStampedServce(this.ref, this.stampRepository);

  // スポットがスタンプ押されているかどうか取得
  Future<List<PlaceModel>> fetchPlaceListByCode(String eventCode) async {
    final csvRepo = ref.read(csvRepositoryProvider);
    final placeCsvList = await csvRepo.fetchPlaceByEventCode(eventCode);

    final jpHolidays =
        await ref.read(getHolidayJpServiceProvider).getHolidays();

    // アプリ用のモデルに変換
    final placeList = placeCsvList
        .map((o) => PlaceModel.fromAsset(data: o, jpHoliday: jpHolidays))
        .toList();

    final stampList =
        await ref.read(stampRepositoryProvider).fetchList(eventCode);
    
    // 各PlaceModelに対してスタンプ状態を更新（mapを使用）
    return placeList.map((place) {
      final stampedData = stampList.firstWhereOrNull(
          (stamp) => stamp.historicSpotId == place.historicSpotId);
      final isStamped =
          stampedData != null && stampedData.stampedDateTimeList.isNotEmpty;

      return place.copyWith(
        isStamped: isStamped,
      );
    }).toList();
  }

  Future<PlaceModel?> fetchPlaceDetail(String spotId, String eventCode) async {
    final placeList = await fetchPlaceListByCode(eventCode);
    
    // PlaceListからspotIdで検索
    try {
      return placeList.firstWhere((place) => place.historicSpotId == spotId);
    } catch (e) {
      // 見つからない場合はnullを返す
      return null;
    }
  }
}
