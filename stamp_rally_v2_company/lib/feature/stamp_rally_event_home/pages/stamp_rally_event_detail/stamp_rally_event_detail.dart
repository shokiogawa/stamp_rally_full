import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_by_event_code_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/provider/complete_card_file_notifier.dart';

class StampRallyEventDetailPage extends HookConsumerWidget {
  const StampRallyEventDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    // 仮のデータ
    final rallyName = selectedEvent?.eventName ?? '';
    final topImageUrl =
        selectedEvent?.topImageUrl ?? 'assets/images/default_event.jpg';
    final period = selectedEvent?.period ?? '';
    final imageHeight = MediaQuery.of(context).size.height * 0.32;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                    imageUrl: topImageUrl,
                    height: imageHeight,
                    fit: BoxFit.fill)),
            const SizedBox(height: 24),
            Text(
              rallyName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today,
                    size: 20, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Text(
                  period,
                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // スタンプラリー開始ボタン
            _StartButton(key: key),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '概要',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(selectedEvent?.description ?? ''),
                )
              ],
            ),
            const SizedBox(height: 24),
            PrizeArea(
                priseName: selectedEvent?.prizeInfoName ?? '',
                priseImage: selectedEvent?.prizeInfoImage ?? ''),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

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
          return ElevatedButton.icon(
            onPressed: () async {
              await LoadingAction.showSnackBar(
                  future: stampRallyEventDetailNotifier.joinStampRally,
                  context: context,
                  successMessage: "スタンプラリーを開始しました",
                  errorMessage: "スタンプラリーの開始に失敗しました",
                  showSuccessSnackBar: true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007B43),
              padding: const EdgeInsets.symmetric(vertical: 8),
              textStyle: const TextStyle(fontSize: 14),
            ),
            icon: const Icon(Icons.flag, color: Colors.white, size: 18),
            label: const Text(
              'スタンプラリー開始する',
              style: TextStyle(color: Colors.white),
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

class PlaceList extends HookConsumerWidget {
  const PlaceList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeAsync = ref.watch(fetchPlaceByEventCodeProvider(
        ref.watch(selectedEventProvider)?.eventCode ?? ''));
    return placeAsync.when(
      data: (places) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio:
                1.2, // Adjusted aspect ratio to make cards smaller
          ),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return GestureDetector(
              onTap: () {
                // Handle place tap
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: place.shrineImage,
                          fit: BoxFit.scaleDown,
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

// 景品紹介ページ
class PrizeArea extends HookConsumerWidget {
  const PrizeArea(
      {super.key, required this.priseName, required this.priseImage});
  final String priseName;
  final String priseImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 仮のデータ
    final prizes = priseName.isNotEmpty
        ? [
            {'image': priseImage, 'title': priseName, 'description': ''},
          ]
        : [];
    if (prizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '景品紹介',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: prizes.length,
            itemBuilder: (context, index) {
              final prize = prizes[index];
              return _buildPrizeCard(
                  prize['image']!, prize['title']!, prize['description']!);
            },
          ),
        )
      ],
    );
  }
}

Widget _buildPrizeCard(String imagePath, String title, String description) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imagePath,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

// 完了カード表示エリア
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
        // スタンプラリーが完了している場合のみ表示
        if (detail?.status == StampRallyEventStatus.completed) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'スタンプラリー完了カード',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007B43), Color(0xFF00A859)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.celebration,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '完了おめでとうございます！',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedEvent?.eventName ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // ここに完了カードの画像を表示予定
                      completeCardNotifier.when(
                        data: (imageFile) {
                          if (imageFile != null) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.white30),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error,
                                          color: Colors.red),
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(color: Colors.white30),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '完了カード画像',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        loading: () => Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                        error: (error, stack) => Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: const Center(
                            child: Icon(Icons.error, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}
