import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/csv/repository/csv.repository.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp/repository/stamp_repository.dart';
import 'package:stamp_rally_v2_fvm/core/service/location/location_service.dart';
import 'package:stamp_rally_v2_fvm/core/service/utility/get_holiday_jp.servce.dart';

part 'fetch_place_and_stamped_provider.g.dart';

@riverpod
Future<List<PlaceModel>> fetchPlaceAndStamped(Ref ref, String eventCode) async {
  // csvからイベント一覧デーを取得
  final csvRepo = ref.read(csvRepositoryProvider);
  final placeCsvList = await csvRepo.fetchPlaceByEventCode(eventCode);

  final jpHolidays = await ref.read(getHolidayJpServiceProvider).getHolidays();

  // アプリ用のモデルに変換
  final placeList = placeCsvList
      .map((o) => PlaceModel.fromAsset(data: o, jpHoliday: jpHolidays))
      .toList();

  final stampList =
      await ref.read(stampRepositoryProvider).fetchList(eventCode);
  final locationService = ref.watch(locationServiceProvider);

  // 各PlaceModelに対して距離を計算し、スタンプ状態と合わせて更新
  final List<PlaceModel> updatedPlaces = [];

  for (final place in placeList) {
    final stampedData = stampList.firstWhereOrNull(
        (stamp) => stamp.historicSpotId == place.historicSpotId);
    final isStamped =
        stampedData != null && stampedData.stampedDateTimeList.isNotEmpty;

    // 現在地からの距離を計算
    final distance = await locationService.distanceFromCurrent(
            lat: place.latitude, lon: place.longitude) ??
        0.0;

    updatedPlaces.add(place.copyWith(
      isStamped: isStamped,
      distanceFromCurrent: distance,
    ));
  }

  return updatedPlaces;
}
