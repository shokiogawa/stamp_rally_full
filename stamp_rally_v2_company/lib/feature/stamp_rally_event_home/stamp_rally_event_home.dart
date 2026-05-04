import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_rally_event_detail/stamp_rally_event_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/stamp_list.dart';

class StampRallyEventHomePage extends HookConsumerWidget {
  const StampRallyEventHomePage({super.key, required this.eventCode});

  final String eventCode;

  // 詳細ページをスタック
  static void push(BuildContext context, String eventCode) {
    StampRallyEventHomePageRoute(eventCode).push(context);
  }

  // 全てをページを置き換え
  static void go(BuildContext context, String eventCode) {
    StampRallyEventHomePageRoute(eventCode).go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const summary = "概要";
    const spotListname = "スポット一覧";

    final placeAsyncNotifier =
        ref.watch(fetchPlaceAndStampedProvider(eventCode));
    final currentIndex = useState(0);

    final eventState = ref.watch(selectedEventProvider);
    final iconList = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.summarize),
        label: summary,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: spotListname,
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.list),
      //   label: 'スタンプラリー一覧',
      // ),
    ];
    final joinedIconList = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: spotListname,
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.summarize),
        label: summary,
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.list),
      //   label: 'スタンプラリー一覧',
      // ),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          eventState?.eventName ?? 'スタンプラリーイベント',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )),
        body: placeAsyncNotifier.when(
            data: (places) {
              final pageList = [
                const StampRallyEventDetailPage(),
                StampListPage(eventCode: eventCode, places: places),
                // const GoshuinBookScreen()
                // StampListMapPage(eventCode: eventCode),
              ];

              final joinedPageList = [
                StampListPage(
                  eventCode: eventCode,
                  places: places,
                ),
                const StampRallyEventDetailPage(),
                // const GoshuinBookScreen()
              ];

              return eventState?.status == StampRallyEventStatus.notStarted
                  ? pageList[currentIndex.value]
                  : joinedPageList[currentIndex.value];
            },
            error: (error, stack) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex.value,
          items: eventState?.status == StampRallyEventStatus.notStarted
              ? iconList
              : joinedIconList,
          onTap: (index) {
            currentIndex.value = index;
          },
        ),
      ),
    );
  }
}
