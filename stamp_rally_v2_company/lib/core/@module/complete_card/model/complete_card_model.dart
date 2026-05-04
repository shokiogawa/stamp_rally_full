import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_card_model.freezed.dart';

part 'complete_card_model.g.dart';

@freezed
class CompleteCardModel with _$CompleteCardModel {
  const factory CompleteCardModel(
      {required String title, required String message}) = _CompleteCardModel;

  factory CompleteCardModel.fromJson(Map<String, dynamic> json) =>
      _$CompleteCardModelFromJson(json);
}
