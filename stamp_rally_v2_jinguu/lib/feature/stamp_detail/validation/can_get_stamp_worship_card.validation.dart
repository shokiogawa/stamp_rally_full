import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_csv_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/service/date_stamp_register_validation.service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/service/gps_stamp_register_validation.service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'can_get_stamp_worship_card.validation.g.dart';

@riverpod
CanGetStampWorshipCardValidation canGetStampWorshipCardValidation(Ref ref) {
  return CanGetStampWorshipCardValidation(
    dateStampRegisterValidationService:
        ref.read(dateStampRegisterValidationServiceProvider),
    gpsStampRegisterValidationService:
        ref.read(gpsStampRegisterValidationServiceProvider),
  );
}

class CanGetStampWorshipCardValidation {
  final DateStampRegisterValidationService dateStampRegisterValidationService;
  final GpsStampRegisterValidationService gpsStampRegisterValidationService;

  CanGetStampWorshipCardValidation({
    required this.dateStampRegisterValidationService,
    required this.gpsStampRegisterValidationService,
  });
  Future<void> execute(PlaceModel place) async {
    // GPSバリデーションの場合
    if (place.typeRegisterStamp == TypeRegisterStamp.gps) {
      final isValid = await gpsStampRegisterValidationService.execute(
          gpsMeter: place.gpsMeter,
          latitude: place.latitude,
          longitude: place.longitude);
      if (!isValid) {
        throw Exception("現在地が取得可能な範囲内にありません");
      }
    }

    // GPSと日付のバリデーションの場合
    if (place.typeRegisterStamp == TypeRegisterStamp.gpsDate) {
      final isValid = await gpsStampRegisterValidationService.execute(
          gpsMeter: place.gpsMeter,
          latitude: place.latitude,
          longitude: place.longitude);
      if (!isValid) {
        throw Exception("現在地が取得可能な範囲内にありません");
      }

      final isValidDate = await dateStampRegisterValidationService.execute(
          place, DateTime.now());
      if (!isValidDate) {
        throw Exception("取得可能期間外です");
      }
    }

    // QRコードのバリデーションの場合
    if (place.typeRegisterStamp == TypeRegisterStamp.qr) {
      throw Exception("QRコードのスタンプ登録は未実装です");
    }
  }
}
