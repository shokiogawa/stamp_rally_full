import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_rally_event_csv_model.freezed.dart';

part 'stamp_rally_event_csv_model.g.dart';

@freezed
class StampRallyEventCsvModel with _$StampRallyEventCsvModel {
  const factory StampRallyEventCsvModel(
      {int? id,
      String? code,
      String? title,
      String? description,
      String? position,
      String? placeDataListCsv,
      String? mainImage,
      String? period,
      String? prizeInfoName,
      String? prizeInfoImage,
      String? status}) = _StampRallyEventCsvModel;

  const StampRallyEventCsvModel._();

  // データをjson化
  factory StampRallyEventCsvModel.fromJson(Map<String, dynamic> json) =>
      _$StampRallyEventCsvModelFromJson(json);
}
