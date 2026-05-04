import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/complete_card/model/complete_card_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/shared_preferences_provider.dart';

part 'complete_card_repository.g.dart';

@riverpod
CompleteCardRepository completeCardRepository(Ref ref) {
  return CompleteCardRepository(ref);
}

class CompleteCardRepository {
  final Ref ref;

  const CompleteCardRepository(this.ref);

  // 達成カード登録
  Future<void> register(CompleteCardLocalModel dto) async {
    final pref = await ref.read(sharedPreferencesProvider.future);

    final data = json.encode(dto.toJson());

    await pref.setString(
        SharedPreferenceKeys.completeCard.name + dto.eventCode, data);
  }

  Future<bool> isExist(String eventCode) async {
    final existData = await fetch(eventCode);
    if (existData != null && existData.title != 'おめでとう') return true;
    return false;
  }

  // 達成カード取得
  Future<CompleteCardLocalModel?> fetch(String eventCode) async {
    final pref = await ref.read(sharedPreferencesProvider.future);
    final data =
        pref.getString(SharedPreferenceKeys.completeCard.name + eventCode);

    // データが存在しない場合は、nullを返す。
    if (data == null) {
      return null;
    }

    return CompleteCardLocalModel.fromJson(json.decode(data));
  }
}
