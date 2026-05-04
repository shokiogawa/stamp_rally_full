import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_input_model.freezed.dart';

part 'stamp_input_model.g.dart';

@freezed
class StampInputModel with _$StampInputModel {
  const StampInputModel._();

  const factory StampInputModel({
    // スタンプを押したスポットのID
    required String historicSpotId,
    required String placeName,
    // スタンプを押した日時のリスト
    // @Default([]) List<DateTime> stampedDateTimeList
  }) = _StampInputModel;

  factory StampInputModel.fromJson(Map<String, dynamic> json) =>
      _$StampInputModelFromJson(json);
}
