import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/repository/stamp_rally_event_repository.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/fetch_stamp_rally_event_list_provider.dart';
import 'package:stamp_rally_v2_fvm/core/service/fetch_stamp_rally_event_list_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_list/provider/fetch_stamp_rally_event_list_provider.dart';

part 'stapm_rally_event_detail_notifier.g.dart';

@immutable
class StampRallyEventDetailNotofierState {
  final String id;
  final String code;
  final String title;
  final String position;
  final String url;
  final String image;
  final String period;
  final StampRallyEventStatus status;
  const StampRallyEventDetailNotofierState({
    required this.id,
    required this.code,
    required this.title,
    required this.position,
    required this.url,
    required this.image,
    required this.period,
    required this.status,
  });
}

@riverpod
class StampRallyEventDetailNotifier extends _$StampRallyEventDetailNotifier {
  StampRallyEventRepository get _stampRallyEventRepository =>
      ref.read(stampRallyEventRepositoryProvider);
  // NotionService get _notionService => ref.read(notionServiceProvider);
  FetchStampRallyEventListService get _fetchStampRallyEventListService =>
      ref.read(fetchStampRallyEventListServiceProvider);

  @override
  FutureOr<StampRallyEventDetailNotofierState?> build(String code) async {
    return fetch(code);
  }

  // 取得
  Future<StampRallyEventDetailNotofierState?> fetch(String code) async {
    final data = await _stampRallyEventRepository.fetchDetail(code);
    final eventList = await _fetchStampRallyEventListService.execute();
    final fetchModel =
        eventList?.firstWhereOrNull((event) => event.code == code);
    if (fetchModel == null) {
      return null;
    }

    return StampRallyEventDetailNotofierState(
      id: fetchModel.id.toString(),
      code: fetchModel.code ?? '',
      title: fetchModel.title ?? '',
      position: fetchModel.position ?? '',
      url: fetchModel.placeDataListCsv ?? '',
      image: fetchModel.mainImage ?? '',
      period: fetchModel.period ?? '',
      status: data?.status ?? StampRallyEventStatus.notStarted,
    );
  }

  // スタンプ参加
  Future<void> joinStampRally() async {
    final data = await future;
    if (data == null) {
      throw Exception("データが存在しません");
    }
    final newData = StampRallyEventLocalModel(
      code: data.code,
      status: StampRallyEventStatus.inProgress,
    );
    await _stampRallyEventRepository.register(newData);

    // スタンプ取得後に再検証
    revlidate(data.code);
  }

  // スタンプ完了
  Future<void> completeStampRally() async {
    final data = await future;
    if (data == null) {
      throw Exception("データが存在しません");
    }
    final newData = StampRallyEventLocalModel(
      code: data.code,
      status: StampRallyEventStatus.completed,
    );

    await _stampRallyEventRepository.update(newData);

    // スタンプ取得後に再検証
    revlidate(data.code);
  }

  // 影響providerを更新
  void revlidate(String eventCode) {
    ref.invalidateSelf();
    ref.invalidate(fetchStampRallyEventListProvider);
    ref.invalidate(fetchStampRallyEventList2Provider);
    ref.invalidate(fetchPlaceAndStampedProvider(eventCode));
  }
}
