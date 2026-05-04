import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';

part 'selected_event_provider.g.dart';

@immutable
final class SelectedEventState {
  final String? eventCode;
  final String? url;
  final String? eventName;
  final String? period;
  final String description;
  final String topImageUrl;
  final String? prizeInfoName;
  final String? prizeInfoImage;
  final StampRallyEventStatus? status;
  const SelectedEventState(
      this.url,
      this.eventCode,
      this.eventName,
      this.period,
      this.description,
      this.topImageUrl,
      this.prizeInfoName,
      this.prizeInfoImage,
      this.status);
}

@Riverpod(keepAlive: true)
class SelectedEvent extends _$SelectedEvent {
  @override
  SelectedEventState? build() {
    return null;
  }

  void setEventModel(
      {required String? url,
      required String? eventCode,
      required String? eventName,
      required String? period,
      required String description,
      required String topImageUrl,
      required String? prizeInfoName,
      required String? prizeInfoImage,
      required StampRallyEventStatus? status}) {
    state = SelectedEventState(url, eventCode, eventName, period, description,
        topImageUrl, prizeInfoName, prizeInfoImage, status);
  }
}
