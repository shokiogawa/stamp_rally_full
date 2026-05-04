import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';

part 'date_stamp_register_validation.service.g.dart';

// 日付可能時間の確認
@riverpod
DateStampRegisterValidationService dateStampRegisterValidationService(Ref ref) {
  return DateStampRegisterValidationService(ref);
}

class DateStampRegisterValidationService {
  final Ref ref;
  DateStampRegisterValidationService(this.ref);

  Future<bool> execute(PlaceModel place, DateTime now) async {
    //  データが存在しない場合
    if (place.dateStart == null || place.dateEnd == null) {
      return false;
    }
    // 現在時刻がスタンプ可能な期間内かどうかをチェック
    if (now.isBefore(place.dateStart!) || now.isAfter(place.dateEnd!)) {
      return false;
    }
    return true;
  }
}
