import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp/model/stamp_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/service/place_and_stamped.service.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp/repository/stamp_repository.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/validation/can_get_stamp_worship_card.validation.dart';

part 'stamp_detail_notifier.g.dart';

@immutable
class StampDetailNotifierState {
  final PlaceModel placeModel;
  final StampLocalModel stampLocalmodel;

  const StampDetailNotifierState(
      {required this.placeModel, required this.stampLocalmodel});
}

@riverpod
class StampDetailNotifier extends _$StampDetailNotifier {
  // スタンプ取得可能かバリデーション
  CanGetStampWorshipCardValidation get canGetStampWorshipCardValidation =>
      ref.read(canGetStampWorshipCardValidationProvider);
  StampRepository get stampRepository => ref.read(stampRepositoryProvider);
  PlaceAndStampedServce get placeAndStampedService =>
      ref.read(placeAndStampedServceProvider);

  Future<PlaceModel> getPlaceModel(String id) async {
    final selectedEventState = ref.watch(selectedEventProvider);

    final place = await ref
        .read(placeAndStampedServceProvider)
        .fetchPlaceDetail(id, eventCode);
    if (place == null) {
      logger.e("スタンプ一覧データが存在しません");
      throw Exception("スタンプ一覧データが存在しません");
    }
    return place;
  }

  @override
  FutureOr<StampDetailNotifierState?> build(
      String historicSpotId, String eventCode) async {
    final data = await stampRepository.fetchDetail(historicSpotId, eventCode);
    final placeData = await getPlaceModel(historicSpotId);
    // データが存在しない場合
    if (data == null) {
      return StampDetailNotifierState(
        placeModel: placeData,
        stampLocalmodel: StampLocalModel(
            eventCode: eventCode,
            historicSpotId: historicSpotId,
            placeName: placeData.name,
            stampedDateTimeList: const []),
      );
    } else {
      return StampDetailNotifierState(
        placeModel: placeData,
        stampLocalmodel: StampLocalModel(
            eventCode: eventCode,
            historicSpotId: historicSpotId,
            placeName: placeData.name,
            stampedDateTimeList: data.stampedDateTimeList),
      );
    }
  }

  // スタンプ一覧取得
  Future<StampDetailNotifierState> fetchDetail(
      String historicSpotId, String eventCode) async {
    final data = await stampRepository.fetchDetail(historicSpotId, eventCode);
    final placeData = await getPlaceModel(historicSpotId);
    // データが存在しない場合
    if (data == null) {
      return StampDetailNotifierState(
        placeModel: placeData,
        stampLocalmodel: StampLocalModel(
            eventCode: eventCode,
            historicSpotId: historicSpotId,
            placeName: placeData.name,
            stampedDateTimeList: const []),
      );
    } else {
      return StampDetailNotifierState(
        placeModel: placeData,
        stampLocalmodel: StampLocalModel(
            eventCode: eventCode,
            historicSpotId: historicSpotId,
            placeName: placeData.name,
            stampedDateTimeList: data.stampedDateTimeList),
      );
    }
  }

  // スタンプ登録
  Future<void> registerStamp(String eventCode) async {
    final stateModel = await future;
    if (stateModel == null) {
      throw Exception("スタンプデータが存在しません");
    }

    final stampLocalModel = stateModel.stampLocalmodel;

    // バリデーション実行
    final place = await getPlaceModel(stampLocalModel.historicSpotId);
    await canGetStampWorshipCardValidation.execute(place);

    final updateStamp = stampLocalModel.registerStamp();
    await stampRepository.register(updateStamp);
    state = AsyncValue.data(
        await fetchDetail(stampLocalModel.historicSpotId, eventCode));

    // スタンプ取得後に再検証
    revlidate();
  }

  // スタンプ登録(QRコード用)
  Future<void> registerStampForQR(
      String historicSpotId, String eventCode) async {
    final targetState = await future;
    if (targetState == null) {
      throw Exception("スタンプデータが存在しません");
    }

    final targetStamp = targetState.stampLocalmodel;

    if (targetStamp.historicSpotId != historicSpotId) {
      throw Exception('このスポットのQRコードではありません');
    }

    // バリデーション実行
    final place = await getPlaceModel(historicSpotId);
    await canGetStampWorshipCardValidation.execute(place);

    final updateStamp = targetStamp.registerStamp();
    await stampRepository.register(updateStamp);
    state = AsyncValue.data(
        await fetchDetail(targetStamp.historicSpotId, eventCode));

    // スタンプ取得後に再検証
    revlidate();
  }

  // 影響providerを更新
  void revlidate() {
    ref.invalidate(fetchPlaceAndStampedProvider);
  }
}
