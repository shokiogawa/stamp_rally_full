import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/database_provider.dart';
import 'package:stamp_rally_v2_fvm/core/shared_preferences_provider.dart';
import 'package:collection/collection.dart';
part 'stamp_rally_event_repository.g.dart';

@riverpod
StampRallyEventRepository stampRallyEventRepository(Ref ref) {
  final database = ref.read(databaseProvider);
  return StampRallyEventRepository(ref, database);
}

class StampRallyEventRepository {
  final Ref ref;

  final Database _database;

  const StampRallyEventRepository(this.ref, this._database);

  // スタンプ一覧取得
  Future<List<StampRallyEventLocalModel>> fetchList() async {
    final key = SharedPreferenceKeys.stampRallyEvent.name;
    final pref = await ref.read(sharedPreferencesProvider.future);
    final existingJsonList = pref.getStringList(key) ?? [];
    final existingDataList = existingJsonList
        .map((e) => StampRallyEventLocalModel.fromJson(json.decode(e)))
        .toList();
    return existingDataList;
  }

  // スタンプイベントデータ取得
  Future<StampRallyEventLocalModel?> fetchDetail(String eventCode) async {
    final existingDataList = await fetchList();
    final existingData = existingDataList.where((e) => e.code == eventCode);
    return existingData.firstOrNull;
  }

  // スタンプ登録
  Future<void> register(StampRallyEventLocalModel stampData) async {
    final key = SharedPreferenceKeys.stampRallyEvent.name;
    try {
      // 存在確認
      if (await isExistEvent(stampData.code)) {
        // await update(stampData);
        return;
      }

      final pref = await ref.read(sharedPreferencesProvider.future);
      final existingDataList = await fetchList();
      // print("Existing data list: $existingDataList");

      existingDataList.add(stampData);
      final jsonList =
          existingDataList.map((e) => json.encode(e.toJson())).toList();

      await pref.setStringList(key, jsonList);
    } on Exception catch (e, stack) {
      rethrow;
    }
  }

  // スタンプ更新
  Future<void> update(StampRallyEventLocalModel stampData) async {
    final key = SharedPreferenceKeys.stampRallyEvent.name;
    try {
      // 存在確認
      if (!await isExistEvent(stampData.code)) {
        await register(stampData);
      }
      // リスト取得
      final existingDataList = await fetchList();
      // 対象のデータを削除
      existingDataList.removeWhere((e) => e.code == stampData.code);
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
  Future<bool> isExistEvent(String? eventCode) async {
    if (eventCode == null) return false;
    final existingDataList = await fetchList();
    final isExistData =
        existingDataList.any((element) => element.code == eventCode);
    return isExistData;
  }

  // // 対象イベントのスタンプ取得
  // Future<RegisterStamp?> getStampDetail(
  //     String placeId, String eventCode) async {
  //   final data = await _database
  //       .query("stamps", where: "place_id = ?", whereArgs: [placeId]);
  //   return data.map((e) => RegisterStamp.fromJson(e)).toList().firstOrNull;
  // }

  // // スタンプ登録
  // Future<void> registerStamp(RegisterStamp registerStamp) async {
  //   await _database.insert("stamps", registerStamp.toJson());
  // }

  // // スタンプ日付リストを更新
  // Future<void> updateStampedDateList(RegisterStamp registerStamp) async {
  //   await _database.update(
  //       "stamps", {'stamped_date_list': registerStamp.stampedDateTimeList},
  //       where: "place_id = ? AND event_code = ?",
  //       whereArgs: [registerStamp.placeId, registerStamp.eventCode]);
  // }
}

class Repositorybase<T> {
  final Ref ref;
  final Database _database;

  const Repositorybase(this.ref, this._database);

  Future<List<T>> fetchList(String? eventCode) async {
    // Implement fetching logic for the specific type T
    throw UnimplementedError();
  }

  Future<T?> fetchDetail(String eventCode) async {
    // Implement fetching detail logic for the specific type T
    throw UnimplementedError();
  }

  Future<void> register(T data) async {
    // Implement registration logic for the specific type T
    throw UnimplementedError();
  }

  Future<void> update(T data) async {
    // Implement update logic for the specific type T
    throw UnimplementedError();
  }

  Future<bool> isExistEvent(String? eventCode) async {
    // Implement existence check logic for the specific type T
    throw UnimplementedError();
  }
}
