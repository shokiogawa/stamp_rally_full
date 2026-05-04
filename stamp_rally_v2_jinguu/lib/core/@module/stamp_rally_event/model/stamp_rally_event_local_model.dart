import 'package:freezed_annotation/freezed_annotation.dart';

part 'stamp_rally_event_local_model.freezed.dart';
part 'stamp_rally_event_local_model.g.dart';

enum StampRallyEventStatus {
  notStarted,
  inProgress,
  completed,
}

@freezed
class StampRallyEventLocalModel with _$StampRallyEventLocalModel {
  const StampRallyEventLocalModel._();

  const factory StampRallyEventLocalModel({
    String? code,
    StampRallyEventStatus? status,
  }) = _StampRallyEventLocalModel;

  static StampRallyEventLocalModel create(String code) {
    return StampRallyEventLocalModel(
      code: code,
      status: StampRallyEventStatus.notStarted,
    );
  }

  // スタンプラリーイベントの開始
  StampRallyEventLocalModel joinStampRally() {
    return StampRallyEventLocalModel(
      code: code,
      status: StampRallyEventStatus.inProgress,
    );
  }

  // スタンプラリーイベントの完了
  StampRallyEventLocalModel completeStampRally() {
    return StampRallyEventLocalModel(
      code: code,
      status: StampRallyEventStatus.completed,
    );
  }

  factory StampRallyEventLocalModel.fromJson(Map<String, dynamic> json) =>
      _$StampRallyEventLocalModelFromJson(json);
}
