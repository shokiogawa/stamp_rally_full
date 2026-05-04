import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/repository/stamp_rally_event_repository.dart';
import 'package:stamp_rally_v2_fvm/core/service/fetch_stamp_rally_event_list_service.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

part 'fetch_stamp_rally_event_list_provider.g.dart';

part 'fetch_stamp_rally_event_list_provider.freezed.dart';

@freezed
class StampRallyEventModel with _$StampRallyEventModel {
  const factory StampRallyEventModel({
    int? id,
    String? code,
    String? title,
    String? description,
    String? position,
    String? placeDataListCsv,
    String? mainImage,
    String? period,
    String? prizeInfoName,
    String? prizeInfoImage,
    StampRallyEventStatus? status,
  }) = _StampRallyEventModel;

  const StampRallyEventModel._();

  // データをjson化
  factory StampRallyEventModel.fromJson(Map<String, dynamic> json) =>
      _$StampRallyEventModelFromJson(json);
}

@riverpod
Future<List<StampRallyEventModel>> fetchStampRallyEventList2(Ref ref) async {
  try {
    final eventList =
        await ref.read(fetchStampRallyEventListServiceProvider).execute();
    if (eventList == null) {
      return [];
    }
    final dto = await ref.watch(stampRallyEventRepositoryProvider).fetchList();
    return eventList.map((v) {
      final targetEvent = dto.firstWhereOrNull((d) => d.code == v.code);
      return StampRallyEventModel(
          id: v.id,
          code: v.code,
          title: v.title,
          description: v.description,
          position: v.position,
          placeDataListCsv: v.placeDataListCsv,
          mainImage: v.mainImage,
          period: v.period,
          prizeInfoName: v.prizeInfoName,
          prizeInfoImage: v.prizeInfoImage,
          status: targetEvent?.status ?? StampRallyEventStatus.notStarted);
    }).toList();
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}
