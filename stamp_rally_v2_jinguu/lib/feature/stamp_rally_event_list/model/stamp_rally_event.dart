import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_csv_model.dart';

part 'stamp_rally_event.freezed.dart';

part 'stamp_rally_event.g.dart';

@freezed
class StampRallyEvent with _$StampRallyEvent {
  const factory StampRallyEvent(
      {String? id,
      String? code,
      String? title,
      String? position,
      String? url,
      String? image,
      String? period,
      String? status,
      bool? isJoined,
      bool? isCompleted}) = _StampRallyEvent;

  const StampRallyEvent._();

  factory StampRallyEvent.fromCsvModel(StampRallyEventCsvModel model) {
    return StampRallyEvent(
        id: model.id.toString(),
        code: model.code,
        title: model.title,
        position: model.position,
        image: model.mainImage,
        period: model.period,
        url: model.placeDataListCsv,
        status: model.status);
  }

  // データをjson化
  factory StampRallyEvent.fromJson(Map<String, dynamic> json) =>
      _$StampRallyEventFromJson(json);
}
