import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_csv_model.freezed.dart';

part 'place_csv_model.g.dart';

enum TypeRegisterStamp { gps, qr, sample, gpsDate }

@freezed
class PlaceCsvModel with _$PlaceCsvModel {
  const factory PlaceCsvModel(
      {required String historicSpotId,
      required String name,
      required String areaName,
      required String yomigana,
      required double longitude,
      required double latitude,
      required TypeRegisterStamp typeRegisterStamp,
      @Default('') String worshipUrl,
      @Default("参拝カード") String img,
      @Default(50) int gpsMeter,
      @Default("") String url,
      @Default("") String proverbs,
      @Default("") String worship_card_top_image_url,
      @Default("") String dateStart,
      @Default("") String dateEnd,
      @Default("") String shrineImage,

      // 平日開始時間
      String? timeStartWeekDays,
      // 平日終了時間
      String? timeEndWeekDays,
      // 休日開始時間
      String? timeStartHoliday,
      // 休日終了時間
      String? timeEndHoliday}) = _PlaceCsvModel;

  factory PlaceCsvModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceCsvModelFromJson(json);
}
