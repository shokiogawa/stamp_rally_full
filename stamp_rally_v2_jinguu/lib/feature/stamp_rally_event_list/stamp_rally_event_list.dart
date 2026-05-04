import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/fetch_stamp_rally_event_list_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/core/service/open_another_url_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/stamp_rally_event_home.dart';

class StampRallyEventListPage extends HookConsumerWidget {
  // 詳細ページをスタック
  static void push(BuildContext context) {
    const StampRallyEventListPageRoute().push(context);
  }

  // 全てをページを置き換え
  static void go(BuildContext context) {
    const StampRallyEventListPageRoute().go(context);
  }

  static void pushReplacement(BuildContext context) {
    const StampRallyEventListPageRoute().pushReplacement(context);
  }

  const StampRallyEventListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final eventsAsync = ref.watch(fetchStampRallyEventListProvider);
    final eventListAsync = ref.watch(fetchStampRallyEventList2Provider);

    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Text(
                "Meguru めぐる旅",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF007B43),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF007B43)
                    // color: Color.fromARGB(255, 232, 197, 2),
                    ),
                child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    final version = snapshot.data?.version ?? '1.0.0';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Meguruめぐる旅",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "バージョン: $version",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                        // Assets.images.icon.image(height: 80, width: 80)
                      ],
                    );
                  },
                ),
              ),
              // ListTile(
              //   leading: const Icon(Icons.settings),
              //   title: const Text('設定'),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: const Icon(Icons.help),
              //   title: const Text('ヘルプ'),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: const Icon(Icons.info),
              //   title: const Text('アプリについて'),
              //   onTap: () {},
              // ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('プライバシーポリシー'),
                onTap: () {
                  OpenAnotherUrlService.openUrl(
                      "https://jinja-net.jp/jinja-shi/%E3%83%97%E3%83%A9%E3%82%A4%E3%83%90%E3%82%B7%E3%83%BC%E3%83%9D%E3%83%AA%E3%82%B7%E3%83%BC.html");
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('ライセンス情報'),
                onTap: () {
                  showLicensePage(context: context);
                },
              ),
            ],
          ),
        ),
        body: eventListAsync.when(
          data: (events) => _buildEventList(events, ref),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'エラーが発生しました',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildEventList(List<StampRallyEventModel> events, WidgetRef ref) {
    final Widget listContent;
    if (events.isEmpty) {
      listContent = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'イベントがありません',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    } else {
      listContent = ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isJoined = event.status == StampRallyEventStatus.inProgress;
        final url = event.placeDataListCsv ?? '';
        final isCompleted = event.status == StampRallyEventStatus.completed;

        return GestureDetector(
          onTap: () {
            if (url.isNotEmpty) {
              StampRallyEventHomePage.push(context, event.code ?? '');
              ref.watch(selectedEventProvider.notifier).setEventModel(
                  url: url,
                  eventCode: event.code,
                  eventName: event.title ?? '',
                  period: event.period,
                  description: event.description ?? '',
                  topImageUrl: event.mainImage ?? '',
                  prizeInfoName: event.prizeInfoName,
                  prizeInfoImage: event.prizeInfoImage,
                  status: event.status);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: event.mainImage != null
                                ? CachedNetworkImage(
                                    imageUrl: event.mainImage!,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Container(
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey,
                                            )))
                                : const SizedBox(
                                    width: 110,
                                    height: 110,
                                  ),
                          ),
                          // 参加状況タグ
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isJoined ? Colors.green : Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                isJoined
                                    ? '参加中'
                                    : isCompleted
                                        ? '達成'
                                        : '未参加',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  event.title ?? '',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              // 達成状況
                              // if (isCompleted) _buildAchievementTag(url)
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  size: 16, color: Colors.blueGrey),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  event.period ?? '期間未定',
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.blueGrey),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (event.position != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.pin_drop,
                                    size: 16, color: Colors.orange),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    event.position!,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black87),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider()
            ],
          ),
        );
      },
    );
    }

    return Column(
      children: [
        Expanded(child: listContent),
        const _SponsorBanner(),
      ],
    );
  }

}

// ── スポンサーバナー ──────────────────────────────────
class _SponsorData {
  final String name;
  final String catchphrase;
  final Color color;
  const _SponsorData({
    required this.name,
    required this.catchphrase,
    required this.color,
  });
}

const _sponsors = [
  _SponsorData(
      name: '伊勢志摩観光協会',
      catchphrase: '神秘の地へ、ようこそ',
      color: Color(0xFF1B5E20)),
  _SponsorData(
      name: '三重県観光連盟',
      catchphrase: 'みえ、めぐる旅',
      color: Color(0xFF0D47A1)),
  _SponsorData(
      name: '神宮会館',
      catchphrase: '伝統と安らぎの宿',
      color: Color(0xFF4A148C)),
  _SponsorData(
      name: '伊勢名物お土産処',
      catchphrase: '旅の思い出をお届け',
      color: Color(0xFFBF360C)),
];

class _SponsorBanner extends StatefulWidget {
  const _SponsorBanner();

  @override
  State<_SponsorBanner> createState() => _SponsorBannerState();
}

class _SponsorBannerState extends State<_SponsorBanner> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _currentPage = (_currentPage + 1) % _sponsors.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text('PR',
                    style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 6),
              const Text('協賛企業',
                  style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(
          height: 68,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _sponsors.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final sponsor = _sponsors[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                child: Container(
                  decoration: BoxDecoration(
                    color: sponsor.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sponsor.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(sponsor.catchphrase,
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_sponsors.length, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
              width: _currentPage == i ? 16 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == i
                    ? const Color(0xFF007B43)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}
