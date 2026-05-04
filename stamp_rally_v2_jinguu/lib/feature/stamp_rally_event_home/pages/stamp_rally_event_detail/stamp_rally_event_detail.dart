import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/provider/complete_card_file_notifier.dart';

const _gold = Color(0xFFC8A951);
const _brown = Color(0xFF3E2000);
const _green = Color(0xFF007B43);
const _cream = Color(0xFFFAF8F2);

class StampRallyEventDetailPage extends HookConsumerWidget {
  const StampRallyEventDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);

    return ColoredBox(
      color: _cream,
      child: CustomScrollView(
        slivers: [
          // ── ヒーロー画像 ──────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              children: [
                selectedEvent?.topImageUrl.isNotEmpty == true
                    ? CachedNetworkImage(
                        imageUrl: selectedEvent!.topImageUrl,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(height: 240, color: Colors.grey[200]),
                        errorWidget: (_, __, ___) =>
                            Container(height: 240, color: Colors.grey[200]),
                      )
                    : Container(height: 240, color: Colors.grey[200]),
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0x77000000)],
                    ),
                  ),
                ),
                if (selectedEvent?.status != null)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: _StatusBadge(status: selectedEvent!.status!),
                  ),
              ],
            ),
          ),

          // ── コンテンツ ────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // イベント名
                  Text(
                    selectedEvent?.eventName ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _brown,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 開催期間
                  if (selectedEvent?.period?.isNotEmpty == true)
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 13, color: _gold),
                        const SizedBox(width: 6),
                        Text(
                          selectedEvent!.period!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // 開始ボタン
                  _StartButton(key: key),

                  const SizedBox(height: 24),
                  const _GoldDivider(),
                  const SizedBox(height: 20),

                  // 概要
                  if (selectedEvent?.description.isNotEmpty == true) ...[
                    const _SectionHeader(label: '概要'),
                    const SizedBox(height: 10),
                    Text(
                      selectedEvent!.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _GoldDivider(),
                    const SizedBox(height: 20),
                  ],

                  // 景品紹介
                  PrizeArea(
                    priseName: selectedEvent?.prizeInfoName ?? '',
                    priseImage: selectedEvent?.prizeInfoImage ?? '',
                  ),

                  // 完了カード
                  const CompletionCardArea(),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── ステータスバッジ ──────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final StampRallyEventStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      StampRallyEventStatus.inProgress => ('参加中', _green),
      StampRallyEventStatus.completed => ('達成済み', _gold),
      _ => ('未参加', Colors.orange),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ── 金色区切り線 ──────────────────────────────────────
class _GoldDivider extends StatelessWidget {
  const _GoldDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration:
              const BoxDecoration(color: _gold, shape: BoxShape.circle),
        ),
        Expanded(
          child: Container(
              height: 1, color: _gold.withValues(alpha: 0.35)),
        ),
        Container(
          width: 5,
          height: 5,
          decoration:
              const BoxDecoration(color: _gold, shape: BoxShape.circle),
        ),
      ],
    );
  }
}

// ── セクションヘッダー ────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: _gold,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _brown,
          ),
        ),
      ],
    );
  }
}

// ── 開始ボタン ────────────────────────────────────────
class _StartButton extends HookConsumerWidget {
  const _StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final stampRallyEventDetail = ref.watch(
        stampRallyEventDetailNotifierProvider(selectedEvent?.eventCode ?? ''));
    final stampRallyEventDetailNotifier = ref.watch(
        stampRallyEventDetailNotifierProvider(selectedEvent?.eventCode ?? '')
            .notifier);

    return stampRallyEventDetail.when(
      data: (detail) {
        if (detail?.status == StampRallyEventStatus.notStarted) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await LoadingAction.showSnackBar(
                    future: stampRallyEventDetailNotifier.joinStampRally,
                    context: context,
                    successMessage: 'スタンプラリーを開始しました',
                    errorMessage: 'スタンプラリーの開始に失敗しました',
                    showSuccessSnackBar: true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.flag, color: Colors.white, size: 18),
              label: const Text(
                'スタンプラリーを開始する',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

// ── 景品紹介エリア ────────────────────────────────────
class PrizeArea extends HookConsumerWidget {
  const PrizeArea(
      {super.key, required this.priseName, required this.priseImage});
  final String priseName;
  final String priseImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (priseName.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(label: '景品紹介'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12)),
                child: Image.asset(
                  priseImage,
                  width: 100,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 100,
                    height: 90,
                    color: Colors.grey[100],
                    child: const Icon(Icons.card_giftcard,
                        color: _gold, size: 36),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '達成賞品',
                        style: TextStyle(
                            fontSize: 11,
                            color: _gold,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        priseName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: _brown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _GoldDivider(),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ── 完了カード表示エリア ──────────────────────────────
class CompletionCardArea extends HookConsumerWidget {
  const CompletionCardArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final stampRallyEventDetail = ref.watch(
        stampRallyEventDetailNotifierProvider(selectedEvent?.eventCode ?? ''));
    final completeCardNotifier = ref.watch(
        completeCardFileNotifierProvider(selectedEvent?.eventCode ?? ''));

    return stampRallyEventDetail.when(
      data: (detail) {
        if (detail?.status != StampRallyEventStatus.completed) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(label: 'スタンプラリー完了カード'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  colors: [Color(0xFF007B43), Color(0xFF00A859)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _green.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.celebration, size: 52, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    '完了おめでとうございます！',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    selectedEvent?.eventName ?? '',
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  completeCardNotifier.when(
                    data: (imageFile) {
                      if (imageFile != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.error, color: Colors.red),
                          ),
                        );
                      }
                      return _completeCardPlaceholder();
                    },
                    loading: () => Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    error: (_, __) => _completeCardPlaceholder(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _completeCardPlaceholder() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.15),
        border: Border.all(color: Colors.white30),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 36, color: Colors.white70),
            SizedBox(height: 6),
            Text('完了カード画像',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
