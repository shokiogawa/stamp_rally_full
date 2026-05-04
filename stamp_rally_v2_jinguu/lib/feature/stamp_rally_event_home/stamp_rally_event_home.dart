import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_rally_event_detail/stamp_rally_event_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/stamp_list.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/stamp_list_map.dart';

const _gold = Color(0xFFC8A951);

class StampRallyEventHomePage extends HookConsumerWidget {
  const StampRallyEventHomePage({super.key, required this.eventCode});

  final String eventCode;

  static void push(BuildContext context, String eventCode) {
    StampRallyEventHomePageRoute(eventCode).push(context);
  }

  static void go(BuildContext context, String eventCode) {
    StampRallyEventHomePageRoute(eventCode).go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(fetchPlaceAndStampedProvider(eventCode));
    final eventState = ref.watch(selectedEventProvider);
    final currentIndex = useState(
      eventState?.status == StampRallyEventStatus.notStarted ? 0 : 1,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            eventState?.eventName ?? 'スタンプラリーイベント',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        body: placeAsync.when(
          data: (places) {
            final pages = [
              const StampRallyEventDetailPage(),
              StampListPage(eventCode: eventCode, places: places),
              StampListMapPage(eventCode: eventCode, places: places),
            ];
            return pages[currentIndex.value];
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
        ),
        bottomNavigationBar: _CustomNavBar(
          currentIndex: currentIndex.value,
          onTap: (i) => currentIndex.value = i,
        ),
      ),
    );
  }
}

// ── カスタムボトムナビゲーションバー ──────────────────
class _CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _CustomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SizedBox(
      height: 64 + bottomPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── バー本体 ────────────────────────────────
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.only(bottom: bottomPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _NavItem(
                      icon: Icons.article_outlined,
                      activeIcon: Icons.article,
                      label: '詳細',
                      isActive: currentIndex == 0,
                      onTap: () => onTap(0),
                    ),
                  ),
                  // 中央ボタン用スペース
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.map_outlined,
                      activeIcon: Icons.map,
                      label: 'マップ',
                      isActive: currentIndex == 2,
                      onTap: () => onTap(2),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── 中央の浮き上がりスタンプボタン ────────
          Positioned(
            top: -22,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => onTap(1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        color: currentIndex == 1 ? _gold : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: _gold, width: 2.5),
                        boxShadow: [
                          BoxShadow(
                            color: _gold.withValues(alpha: 0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.apps_rounded,
                        color: currentIndex == 1 ? Colors.white : _gold,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'スタンプ',
                      style: TextStyle(
                        fontSize: 10,
                        color: currentIndex == 1 ? _gold : Colors.grey,
                        fontWeight: currentIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: isActive ? _gold : Colors.grey,
            size: 24,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? _gold : Colors.grey,
              fontWeight:
                  isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
