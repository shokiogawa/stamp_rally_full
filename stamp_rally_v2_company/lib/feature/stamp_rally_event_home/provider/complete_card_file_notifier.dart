import 'dart:io';
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/service/download_image.service.dart';

part 'complete_card_file_notifier.g.dart';

// 完了カード画像の状態管理

@riverpod
class CompleteCardFileNotifier extends _$CompleteCardFileNotifier {
  @override
  FutureOr<File?> build(String eventCode) async {
    return fetchFile(eventCode);
  }

  // 完了カードの画像を取得
  Future<File?> fetchFile(String eventCode) async {
    return await DownloadService.getCompleteCardImage(eventCode);
  }

  // 完了カードの画像を登録
  Future<void> registerCompleteCard(
      Uint8List imageBytes, String eventCode) async {
    await DownloadService.saveCompleteCardImage(imageBytes, eventCode);

    // 画像を保存した後に再度ファイルを取得して更新
    final file = await fetchFile(eventCode);
    state = AsyncValue.data(file);
  }

  // 完了カードの画像を削除
  Future<void> deleteCompleteCard() async {
    final file = state.value;
    if (file != null && await file.exists()) {
      await file.delete();
      state = const AsyncValue.data(null);
    }
  }
}
