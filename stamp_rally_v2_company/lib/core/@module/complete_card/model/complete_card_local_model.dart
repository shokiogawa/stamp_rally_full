import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_card_local_model.freezed.dart';

part 'complete_card_local_model.g.dart';

@freezed
class CompleteCardLocalModel with _$CompleteCardLocalModel {
  const CompleteCardLocalModel._();

  const factory CompleteCardLocalModel(
      {required String eventCode,
      required String title,
      required DateTime completeDateTime,
      required String message}) = _CompleteCardLocalModel;

  // 登録用のコンストラクタ
  factory CompleteCardLocalModel.create(
      {required String eventCode,
      required String title,
      required String message,
      required DateTime now}) {
    return CompleteCardLocalModel(
        eventCode: eventCode,
        completeDateTime: now,
        title: title,
        message: message);
  }

  factory CompleteCardLocalModel.fromJson(Map<String, dynamic> json) =>
      _$CompleteCardLocalModelFromJson(json);
}
