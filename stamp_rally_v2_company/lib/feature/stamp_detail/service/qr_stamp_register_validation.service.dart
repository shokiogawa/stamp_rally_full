import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_stamp_register_validation.service.g.dart';

@riverpod
QrStampRegisterValidationService qrStampRegisterValidationService(Ref ref) {
  return QrStampRegisterValidationService(ref);
}

class QrStampRegisterValidationService {
  final Ref ref;
  QrStampRegisterValidationService(this.ref);

  Future<bool> execute(PlaceModel place, String scannedQrCode) async {
    try {
      return false;
    } catch (e) {
      // Handle any errors
      return false;
    }
  }
}
