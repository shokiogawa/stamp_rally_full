import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/stamp_detail.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/widget/complete_card_dialog.dart';

const _vermillion = Color(0xFFB22222);
const _gold = Color(0xFFC8A951);
const _brown = Color(0xFF3E2000);

class StampListPage extends HookConsumerWidget {
  const StampListPage(
      {super.key, required this.eventCode, required this.places});

  final String eventCode;
  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acquiredCount = places.where((p) => p.isStamped).length;
    final totalCount = places.length;
    final isComplete = acquiredCount == totalCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _StampProgressHeader(
            acquiredCount: acquiredCount,
            totalCount: totalCount,
          ),
          Expanded(
            child: StampListBody(
              eventCode: eventCode,
              places: places,
              isComplete: isComplete,
            ),
          ),
        ],
      ),
    );
  }
}

// ── ヘッダー ──────────────────────────────────────────
class _StampProgressHeader extends StatelessWidget {
  final int acquiredCount;
  final int totalCount;

  const _StampProgressHeader({
    required this.acquiredCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalCount > 0 ? acquiredCount / totalCount : 0.0;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _gold, width: 1.5)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: _gold, size: 18),
              const SizedBox(width: 8),
              Text(
                'スタンプ $acquiredCount / $totalCount',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _brown,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.brown[100],
              valueColor: const AlwaysStoppedAnimation<Color>(_vermillion),
            ),
          ),
        ],
      ),
    );
  }
}

// ── スタンプ一覧 ──────────────────────────────────────
class StampListBody extends HookConsumerWidget {
  final String eventCode;
  final List<PlaceModel> places;
  final bool isComplete;

  const StampListBody({
    super.key,
    required this.eventCode,
    required this.places,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDataAsync =
        ref.watch(stampRallyEventDetailNotifierProvider(eventCode));
    final eventDataNotifier =
        ref.watch(stampRallyEventDetailNotifierProvider(eventCode).notifier);

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: places.length,
            itemBuilder: (context, index) {
              return _StampCard(place: places[index], index: index);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: eventDataAsync.when(
            data: (event) => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isComplete ? _vermillion : Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isComplete
                    ? () async {
                        await eventDataNotifier.completeStampRally();
                        if (context.mounted) {
                          final completeCardUrl =
                              event?.url.replaceFirst(RegExp(r'/data/.*'), '');
                          showCompleteCardDialog(context, event?.code ?? '',
                              completeCardUrl ?? '');
                        }
                      }
                    : null,
                child: const Text(
                  '✦ スタンプラリー達成！ ✦',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            loading: () => ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: null,
              child: const Text('✦ スタンプラリー達成！ ✦',
                  style: TextStyle(color: Colors.white)),
            ),
            error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
          ),
        ),
      ],
    );
  }
}

// ── スタンプカード（円形） ─────────────────────────────
class _StampCard extends StatelessWidget {
  final PlaceModel place;
  final int index;

  const _StampCard({required this.place, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => StampDetailScreen.push(context, place.historicSpotId),
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: place.isStamped
                  ? const _StampedCircle()
                  : _UnstampedCircle(number: index + 1),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            place.name,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: place.isStamped ? _brown : Colors.brown[300],
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StampedCircle extends StatelessWidget {
  const _StampedCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: _vermillion.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Image.asset(
            'assets/images/jinjya6.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _UnstampedCircle extends StatelessWidget {
  final int number;
  const _UnstampedCircle({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown[50],
        border: Border.all(
          color: Colors.brown.shade200,
          width: 1.5,
        ),
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.brown[200],
          ),
        ),
      ),
    );
  }
}
