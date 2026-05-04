import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp/model/stamp_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/database_provider.dart';
import 'package:stamp_rally_v2_fvm/core/shared_preferences_provider.dart';
import 'package:collection/collection.dart';
part 'stamp_repository.g.dart';

@riverpod
StampRepository stampRepository(Ref ref) {
  final database = ref.read(databaseProvider);
  return StampRepository(ref, database);
}

class StampRepository {
  final Ref ref;

  final Database _database;

  const StampRepository(this.ref, this._database);

  // スタンプ一覧取得
  Future<List<StampLocalModel>> fetchList(String eventCode) async {
    final key = '${SharedPreferenceKeys.stamp.name}"/"$eventCode';
    final pref = await ref.read(sharedPreferencesProvider.future);
    final existingJsonList = pref.getStringList(key) ?? [];
    final existingDataList = existingJsonList
        .map((e) => StampLocalModel.fromJson(json.decode(e)))
        .toList();
    return existingDataList;
  }

  // スタンプ詳細データ取得
  Future<StampLocalModel?> fetchDetail(
      String historicSpotId, String eventCode) async {
    final existingDataList = await fetchList(eventCode);
    final existingData =
        existingDataList.where((e) => e.historicSpotId == historicSpotId);
    return existingData.firstOrNull;
  }

  // スタンプ登録
  Future<void> register(StampLocalModel stampData) async {
    final key = '${SharedPreferenceKeys.stamp.name}"/"${stampData.eventCode}';
    try {
      // 存在確認
      if (await isStamped(stampData.historicSpotId, stampData.eventCode)) {
        await update(stampData);
        return;
      }

      final pref = await ref.read(sharedPreferencesProvider.future);
      final existingDataList = await fetchList(stampData.eventCode);

      existingDataList.add(stampData);
      final jsonList =
          existingDataList.map((e) => json.encode(e.toJson())).toList();

      await pref.setStringList(key, jsonList);
    } on Exception catch (e, stack) {
      rethrow;
    }
  }

  // スタンプ更新
  Future<void> update(StampLocalModel stampData) async {
    final key = '${SharedPreferenceKeys.stamp.name}"/"${stampData.eventCode}';
    try {
      // 存在確認
      if (!await isStamped(stampData.historicSpotId, stampData.eventCode)) {
        throw Exception("Data is Not exist");
      }
      // リスト取得
      final existingDataList = await fetchList(stampData.eventCode);
      // 対象のデータを削除
      existingDataList
          .removeWhere((e) => e.historicSpotId == stampData.historicSpotId);
      // 新しいデータを追加
      existingDataList.add(stampData);
      final pref = await ref.read(sharedPreferencesProvider.future);

      // json化
      final jsonList =
          existingDataList.map((e) => json.encode(e.toJson())).toList();
      // 登録
      await pref.setStringList(key, jsonList);
    } on Exception catch (e) {
      return;
    }
  }

  // 存在確認
  Future<bool> isStamped(String historicSpotId, String eventCode) async {
    final existingDataList = await fetchList(eventCode);
    final isExistData = existingDataList
        .any((element) => element.historicSpotId == historicSpotId);
    return isExistData;
  }
}
