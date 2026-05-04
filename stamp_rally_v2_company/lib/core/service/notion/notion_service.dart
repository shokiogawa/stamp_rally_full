// import 'dart:convert';
// import 'package:collection/collection.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_notion_model.dart';
// import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

// part 'notion_service.g.dart';

// @riverpod
// NotionService notionService(Ref ref) {
//   return NotionService();
// }

// class NotionService {
//   static const String _apiKey = String.fromEnvironment('notionApiKey');

//   Future<List<StampRallyEventNotionModel>> fetchStampEventList() async {
//     try {
//       const databaseId = String.fromEnvironment('notionStampRallyEventList');
//       final url =
//           Uri.parse('https://api.notion.com/v1/databases/$databaseId/query');
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': 'Bearer $_apiKey',
//           'Notion-Version': '2022-06-28',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({}),
//       );

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);

//         final jsonMap = json['results'] as List;
//         final jsonProperties = jsonMap.map((v) => v['properties']);
//         final data = jsonProperties
//             .map((v) => StampRallyEventNotionModel.fromNotionJson(v))
//             .toList();
//         return data;
//       } else {
//         throw Exception('データが存在しません');
//       }
//     } catch (e, stackTrace) {
//       logger.e(e, stackTrace: stackTrace);
//       rethrow;
//     }
//   }

//   Future<StampRallyEventNotionModel?> fetchStampEventDetail(String code) async {
//     final data = await fetchStampEventList();
//     return data.firstWhereOrNull((e) => e.code == code);
//   }
// }
