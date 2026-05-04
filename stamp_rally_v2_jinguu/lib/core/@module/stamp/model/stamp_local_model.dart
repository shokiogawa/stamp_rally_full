import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_local_model.freezed.dart';
part 'stamp_local_model.g.dart';

@freezed
class StampLocalModel with _$StampLocalModel {
  const StampLocalModel._();

  const factory StampLocalModel(
      {required String eventCode,
      // スタンプを押したスポットのID
      required String historicSpotId,
      required String placeName,
      // スタンプを押した日時のリスト
      @Default([]) List<DateTime> stampedDateTimeList}) = _StampLocalModel;

  // スタンプ登録用のコンストラクタ
  StampLocalModel registerStamp() {
    // 今日の日付を追加
    final listData = List<DateTime>.from(stampedDateTimeList).toList();
    listData.add(DateTime.now());

    // 降順でソート
    listData.sort(((a, b) => b.compareTo(a)));

    //3つまで取得し登録する。
    final registerDateList = listData.take(3).toList();

    return StampLocalModel(
        eventCode: eventCode,
        historicSpotId: historicSpotId,
        placeName: placeName,
        stampedDateTimeList: registerDateList);
  }

  factory StampLocalModel.fromJson(Map<String, dynamic> json) =>
      _$StampLocalModelFromJson(json);
}
