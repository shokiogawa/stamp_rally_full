import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/complete_card/model/complete_card_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/complete_card/repository/complete_card_repository.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/service/fetch_complete_card_service.dart';

part 'complete_card_notifier.g.dart';

@riverpod
class CompleteCardNotifier extends _$CompleteCardNotifier {
  final revalidateProviders = [];

  CompleteCardRepository get _completeCardRepository =>
      ref.read(completeCardRepositoryProvider);

  FetchCompleteCardService get _fetchCompleteCardService =>
      ref.read(fetchCompleteCardServiceProvider);

  @override
  FutureOr<CompleteCardLocalModel?> build(String url) async {
    return fetch(url);
  }

  // 取得
  Future<CompleteCardLocalModel?> fetch(String url) async {
    final selectedEventCode = ref.watch(selectedEventProvider)?.eventCode ?? '';
    final isExist = await _completeCardRepository.isExist(selectedEventCode);

    // データが存在しない場合登録する
    if (!isExist) {
      await register(url);
    }

    return await _completeCardRepository.fetch(selectedEventCode);
  }

  // 登録
  Future<void> register(String url) async {
    final selectedEvent = ref.watch(selectedEventProvider);
    final targetData = await _fetchCompleteCardService.execute(url);
    if (targetData == null) {
      return;
    }
    final completeCard = CompleteCardLocalModel.create(
        eventCode: selectedEvent?.eventCode ?? '',
        message: targetData.message,
        title: targetData.title,
        now: DateTime.now());

    await _completeCardRepository.register(completeCard);
    // スタンプ取得後に再検証
    revlidate();
  }

  // 影響providerを更新
  void revlidate() {
    for (var provider in revalidateProviders) {
      ref.invalidate(provider);
    }
  }
}
