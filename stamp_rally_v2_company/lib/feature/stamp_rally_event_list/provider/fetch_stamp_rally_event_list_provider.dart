import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/repository/stamp_rally_event_repository.dart';
import 'package:stamp_rally_v2_fvm/core/service/fetch_stamp_rally_event_list_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_list/model/stamp_rally_event.dart';

part 'fetch_stamp_rally_event_list_provider.g.dart';

@riverpod
Future<List<StampRallyEvent>> fetchStampRallyEventList(Ref ref) async {
  final fetchService = ref.read(fetchStampRallyEventListServiceProvider);
  final dto = await ref.watch(stampRallyEventRepositoryProvider).fetchList();
  final stampRallyEventList = await fetchService.execute();
  if (stampRallyEventList == null) {
    return [];
  }

  // csvからの取得
  final model = stampRallyEventList
      .map((e) => StampRallyEvent.fromCsvModel(e))
      .where((m) => m.status == "active")
      .toList();

  // ローカルからの取得と突合
  final returnModel = model
      .map((e) => e.copyWith(
            isJoined: dto.any((d) => d.code == e.code),
          ))
      .toList();
  return returnModel;
}
