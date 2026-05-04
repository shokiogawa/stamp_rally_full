// import 'dart:convert';

// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_csv_model.dart';
// import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
// import 'package:stamp_rally_v2_fvm/core/service/csv/csv.service.dart';

// class PlaceRepository {
//   final Ref ref;
//   final CsvService csvService;

//   const PlaceRepository(this.ref, this.csvService);

//   Future<List<PlaceModel>> fetchPlaceList(final csvUrl) async {
//     final json = await csvService.convertCsvToJson(url: csvUrl);
//     if (json == null) {
//       return [];
//     }

//     final jpHolidays = await getHolidays();

//     // データが存在しない場合は、削除
//     json.removeWhere(
//         (element) => (element['historicSpotId'] as String).isEmpty);

//     return json
//         .map((o) => PlaceModel.fromAsset(
//             data: PlaceCsvModel.fromJson(o), jpHoliday: jpHolidays))
//         .toList();
//   }

//   Future<List<DateTime>> getHolidays() async {
//     const String url = 'https://holidays-jp.github.io/api/v1/date.json';

//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       return data.keys.map((key) => DateTime.parse(key)).toList();
//     } else {
//       throw Exception('Failed to load holidays');
//     }
//   }
// }
