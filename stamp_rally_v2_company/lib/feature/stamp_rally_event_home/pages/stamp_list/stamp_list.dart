import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/stamp_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/show_map_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/stamp_list_map.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/widget/complete_card_dialog.dart';

enum StampListTypeEnum { list, map, googleMap }

class StampListPage extends HookConsumerWidget {
  const StampListPage(
      {super.key, required this.eventCode, required this.places});

  final String eventCode;
  final List<PlaceModel> places;

  // 詳細ページをスタック
  // static void push(BuildContext context, String eventCode) {
  //   StampListPageRoute(eventCode).push(context);
  // }

  // 全てをページを置き換え
  // static void go(BuildContext context, String eventCode) {
  //   StampListPageRoute(eventCode).go(context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showMapNotifier = ref.watch(showMapProvider.notifier);
    final showMap = ref.watch(showMapProvider);
    final acquiredCount = places.where((place) => place.isStamped).length;
    final totalCount = places.length;
    final isComplete = acquiredCount == totalCount;
    return Scaffold(
        floatingActionButton: !showMap
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  showMapNotifier.toggleMapView();
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      color: Color(0xFF6F4E37),
                    ),
                    Text(
                      "マップ",
                      style: TextStyle(fontSize: 9),
                    )
                  ],
                ),
              )
            : null,
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 取得スタンプ
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        '取得スタンプ $acquiredCount / $totalCount',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 15,
                child: Container(
                  child: showMap
                      ? StampListMapPage(eventCode: eventCode, places: places)
                      // ? GoogleMapPage(eventCode: eventCode)
                      : StampListBody(
                          eventCode: eventCode,
                          places: places,
                          isComplete: isComplete,
                        ),
                )),
          ],
        ));
  }
}

// スタンプ一覧
class StampListBody extends HookConsumerWidget {
  final String eventCode;
  final List<PlaceModel> places;
  final bool isComplete;
  const StampListBody(
      {super.key,
      required this.eventCode,
      required this.places,
      required this.isComplete});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDataAsync =
        ref.watch(stampRallyEventDetailNotifierProvider(eventCode));
    final eventDataNotifier =
        ref.watch(stampRallyEventDetailNotifierProvider(eventCode).notifier);
    final cardHeight = MediaQuery.of(context).size.height * 0.12;
    final aspectRation = MediaQuery.of(context).size.height * 0.0012;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: aspectRation,
              ),
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        StampDetailScreen.push(context, place.historicSpotId);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: place.shrineImage.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: place.shrineImage,
                                    fit: BoxFit.cover,
                                    height: cardHeight,
                                    width: double.infinity,
                                    placeholder: (context, url) => Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: cardHeight,
                                      width: double.infinity,
                                      child: const Icon(Icons.image),
                                    ),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        height: cardHeight,
                                        width: double.infinity,
                                        child: const Icon(Icons.image),
                                      );
                                    },
                                  )
                                : Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    height: cardHeight,
                                    width: double.infinity,
                                    child: const Icon(Icons.image),
                                  ),
                          ),
                          if (place.isStamped)
                            Positioned.fill(
                              top: 0,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                    'assets/images/stamp.png',
                                    fit: BoxFit.contain,
                                    width: 50,
                                    height: 50,
                                  )),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      place.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 0, right: 10, left: 10),
                child: SizedBox(
                    width: double.infinity,
                    child: eventDataAsync.when(
                        data: (event) {
                          return Row(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF007B43),
                                      ),
                                      onPressed: isComplete
                                          ? () async {
                                              await eventDataNotifier
                                                  .completeStampRally();
                                              if (context.mounted) {
                                                final completeCardUrl =
                                                    event?.url?.replaceFirst(
                                                        RegExp(r'/data/.*'),
                                                        '');
                                                showCompleteCardDialog(
                                                    context,
                                                    event?.code ?? '',
                                                    completeCardUrl ?? '');
                                              }
                                            }
                                          : null,
                                      child: const Text(
                                        "スタンプラリー達成！",
                                        style: TextStyle(color: Colors.white),
                                      ))),
                              Expanded(flex: 1, child: Container())
                            ],
                          );
                        },
                        loading: () => const ElevatedButton(
                            onPressed: null,
                            child: Text(
                              "スタンプラリー達成！",
                              style: TextStyle(color: Colors.white),
                            )),
                        error: (error, stack) =>
                            Center(child: Text('エラーが発生しました: $error')))),
              ))
        ],
      ),
    );
  }
}
