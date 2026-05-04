import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_csv_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/@module/stamp_rally_event/model/stamp_rally_event_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/core/utility/format_japanese_date.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/provider/stamp_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/provider/worship_card_file_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/qr_code_scanner.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/widget/worship_card_dialog.dart';
import 'package:stamp_rally_v2_fvm/core/service/open_another_url_service.dart';

class StampDetailScreen extends HookConsumerWidget {
  const StampDetailScreen({super.key, required this.placeId});

  final String placeId;

  // 詳細ページをスタック
  static void push(BuildContext context, String placeId) {
    StampDetailRoute(placeId).push(context);
  }

  // 全てをページを置き換え
  static void go(BuildContext context, String placeId) {
    StampDetailRoute(placeId).go(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);

    final asyncNotifier = ref.watch(
        stampDetailNotifierProvider(placeId, selectedEvent?.eventCode ?? ''));
    // final notifier = ref.watch(
    //     stampDetailNotifierProvider(placeId, selectedEvent?.eventCode ?? '')
    //         .notifier);
    // final place = notifier.getPlaceModel(placeId);

    // 神社写真

    const image = 'assets/images/oshiyama.jpg';

    return asyncNotifier.when(
      data: (data) {
        final place = data!.placeModel;
        final placeImage = data!.placeModel.shrineImage ?? '';
        return Scaffold(
          appBar: AppBar(
            title: Text(data?.placeModel.name ?? ''),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: placeImage!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: placeImage,
                            height: 200,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              height: 200,
                              color: Colors.grey,
                            ),
                          )
                        : Image.asset(
                            image,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: data != null &&
                                    data.stampLocalmodel.stampedDateTimeList
                                        .isNotEmpty
                                ? Colors.green
                                : Colors.grey,
                            size: 20,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            data?.stampLocalmodel.placeName ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.open_in_new_rounded,
                                  size: 25,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  '詳細を見る',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.blueAccent),
                                ),
                              ],
                            ),
                            onTap: () async {
                              await OpenAnotherUrlService.openUrl(
                                  data!.placeModel.url);
                            },
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.map_rounded,
                                  size: 25,
                                  color: Colors.brown,
                                ),
                                Text(
                                  'Googleマップ',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.brown),
                                ),
                              ],
                            ),
                            onTap: () async {
                              await OpenAnotherUrlService.openGoogleMap(
                                place!.latitude.toString(),
                                place.longitude.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StampAndWorshipButton(place: place),

                  const SizedBox(height: 16),
                  // スタンプ押下説明
                  StampDetailDescription(place: place),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      'スタンプ履歴を表示',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.history, color: Colors.blue),
                    children:
                        data.stampLocalmodel.stampedDateTimeList.isNotEmpty
                            ? data.stampLocalmodel.stampedDateTimeList
                                .map((historyDateTime) {
                                return Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/stamp.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          formatJapaneseDate(historyDateTime),
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ));
                              }).toList()
                            : [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'まだスタンプは取得されていません。',
                                  ),
                                )
                              ],
                  ),
                  // const SizedBox(height: 24),
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      '参拝カードを表示',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    leading:
                        const Icon(Icons.card_giftcard, color: Colors.brown),
                    children: [
                      WorshipCardImage(
                        historicSpotId: place.historicSpotId,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
    );
  }
}

class StampAndWorshipButton extends HookConsumerWidget {
  final PlaceModel place;
  const StampAndWorshipButton({super.key, required this.place});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worshipCardNotifier = ref
        .watch(worshipCardFilesNotifierProvider(place.historicSpotId).notifier);
    final selectedEvent = ref.watch(selectedEventProvider);
    final notifier = ref.watch(stampDetailNotifierProvider(
            place.historicSpotId, selectedEvent?.eventCode ?? '')
        .notifier);

    final eventAsync = ref.watch(
        stampRallyEventDetailNotifierProvider(selectedEvent?.eventCode ?? ''));
    final stampRallyEventDetailNotifier = ref.watch(
        stampRallyEventDetailNotifierProvider(selectedEvent?.eventCode ?? '')
            .notifier);

    return eventAsync.when(
      data: (event) {
        if (event?.status == StampRallyEventStatus.notStarted) {
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
            icon: const Icon(Icons.flag, color: Colors.white, size: 18),
            label: const Text(
              'スタンプラリー開始する',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // スタンプ取得ボタン
            ElevatedButton.icon(
              onPressed: () async {
                // QRコードが必要な場合はQRコード画面に遷移する。
                if (place.typeRegisterStamp == TypeRegisterStamp.qr) {
                  QrCodeScannerScreen.push(context, place.historicSpotId);
                } else {
                  // それ以外は、QRコード以外のチェック
                  LoadingAction.showSnackBar(
                      future: () {
                        // スタンプ登録処理
                        return notifier
                            .registerStamp(selectedEvent?.eventCode ?? '');
                      },
                      context: context,
                      successMessage: "スタンプを取得しました。",
                      errorMessage: "",
                      showSuccessSnackBar: true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007B43),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.verified, color: Colors.white),
              label: const Text(
                'スタンプを取得',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            // 参拝カード取得ボタン
            ElevatedButton.icon(
              onPressed: () async {
                await LoadingAction.showSnackBar(
                    future: () async {
                      await worshipCardNotifier.checkCanGet(place);
                    },
                    context: context,
                    successMessage: "",
                    errorMessage: "",
                    showSuccessSnackBar: false,
                    onSucess: () async {
                      if (context.mounted) {
                        // 参拝カードダイアログを表示
                        showWorshipCardDialog(context, place);
                      }
                    });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F4E37),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
              icon: const Icon(Icons.card_membership, color: Colors.white),
              label: const Text(
                '参拝カードを取得',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
    );
  }
}

// 説明
class StampDetailDescription extends StatelessWidget {
  final PlaceModel place;

  const StampDetailDescription({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("取得条件"),
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 5, left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (place.typeRegisterStamp == TypeRegisterStamp.qr)
                const Text(
                  'QRコードを読み取ってスタンプを取得してください',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              if (place.typeRegisterStamp == TypeRegisterStamp.gps ||
                  place.typeRegisterStamp == TypeRegisterStamp.gpsDate)
                Text(place.descriptionGpsmeter,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              if (place.typeRegisterStamp == TypeRegisterStamp.gpsDate &&
                  place.descriptionWeekDays.isNotEmpty)
                Text(
                  place.descriptionWeekDays,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              if (place.typeRegisterStamp == TypeRegisterStamp.gpsDate &&
                  place.descriptionHoliday.isNotEmpty)
                Text(
                  place.descriptionHoliday,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
            ],
          ),
        )
      ],
    );
  }
}

// 参拝カードの画像を表示するウィジェット
class WorshipCardImage extends HookConsumerWidget {
  final String historicSpotId;

  const WorshipCardImage({super.key, required this.historicSpotId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileNotifier = ref.watch(
      worshipCardFilesNotifierProvider(historicSpotId),
    );
    return fileNotifier.when(
      data: (files) {
        if (files.isEmpty) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(16.0), child: Text('参拝カードはまだありません')));
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 10,
          ),
          itemCount: files.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Image.file(
                files[index],
                fit: BoxFit.scaleDown,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.zero,
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 1,
                      maxScale: 4,
                      child: Image.file(
                        files[index],
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: Text('参拝カードはまだありません')),
    );
  }
}
