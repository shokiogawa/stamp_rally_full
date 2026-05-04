import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/service/location/location_service.dart';

part 'gps_stamp_register_validation.service.g.dart';

// 位置情報の確認
@riverpod
GpsStampRegisterValidationService gpsStampRegisterValidationService(Ref ref) {
  final locationService = ref.read(locationServiceProvider);
  return GpsStampRegisterValidationService(ref, locationService);
}

class GpsStampRegisterValidationService {
  final Ref ref;
  final LocationService locationService;
  GpsStampRegisterValidationService(this.ref, this.locationService);

  Future<bool> execute(
      {required int gpsMeter,
      required double latitude,
      required double longitude}) async {
    // 圏内にいるか確認
    return await locationService.isWithinDistance(
        meter: double.parse(gpsMeter.toString()),
        lat: latitude,
        lon: longitude);
  }
}
