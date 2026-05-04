import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/extention/gloabal_key.extention.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/service/open_another_url_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/provider/worship_card_file_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/utility.dart';

/// 参拝カードダイアログを表示する。
void showWorshipCardDialog(BuildContext context, PlaceModel place) {
  showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        //　GlobalKeyを作成
        final globalKey = GlobalKey();
        return MediaQuery(
          data:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Dialog(
                clipBehavior: Clip.antiAlias,
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 60),
                child: Consumer(
                  builder: (context, WidgetRef ref, _) {
                    return SizedBox(
                      child: Column(
                        children: [
                          Expanded(
                              flex: 12,
                              child: _WorshipCard(
                                  globalKey: globalKey, place: place)),
                          Expanded(
                              flex: 1,
                              child: _CompleteButton(
                                  globalKey: globalKey, place: place))
                        ],
                      ),
                    );
                  },
                )),
          ),
        );
      });
}

class _WorshipCard extends HookConsumerWidget {
  final GlobalKey globalKey;
  final PlaceModel place;

  const _WorshipCard({super.key, required this.globalKey, required this.place});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeNameSize = place.name.contains('\n') ? 22.0 : 27.0;
    return RepaintBoundary(
      key: globalKey,
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: const Color(0xFFF3CCFF),
            child: Column(
              children: [
                // 上の画像。
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: place.worshipCardTopUrl,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    // 神社名
                    Flexible(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          place.name,
                          style: GoogleFonts.sawarabiMincho(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              fontSize: placeNameSize,
                              color: Colors.purple),
                        ),
                      ),
                    ),
                    // 参拝カードメッセージ
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 2),
                        child: Center(
                          child: Text(
                            place.proverbs,
                            style: GoogleFonts.sawarabiMincho(
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              fontSize: StampDetailUtility.getFontSizeByLength(
                                  place.proverbs),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: place.shrineImage,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Expanded(
                              child: Text(
                                'ID: ${place.historicSpotId}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                place.areaName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${StampDetailUtility.formatJapaneseDate(DateTime.now())}  参拝',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            )
                          ],
                        )),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 完了ボタン
class _CompleteButton extends HookConsumerWidget {
  const _CompleteButton(
      {super.key, required this.globalKey, required this.place});

  final PlaceModel place;

  final GlobalKey globalKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final worshipCardNotifier = ref
        .watch(worshipCardFilesNotifierProvider(place.historicSpotId).notifier);
    final selectedEvent = ref.watch(selectedEventProvider);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          children: [
            // アルバムに保存ボタン
            Expanded(
              flex: 4,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: () async {
                    // スナックバーを出す処理
                    await LoadingAction.showSnackBar(
                      future: () async {
                        // widgetを画像化
                        final pngBytes = await globalKey.createWidgetImage();

                        // 参拝カード保存
                        await worshipCardNotifier.registerWorshipCard(
                            pngBytes, place);
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                      context: context,
                      successMessage: "保存に成功しました。",
                      errorMessage: "保存に失敗しました。再度やり直してください。",
                      showSuccessSnackBar: true,
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        "参拝カード保存",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )),
            ),
            Visibility(
                visible: place.isWorshipCardWeb,
                child: const SizedBox(width: 10)),
            // 別サイトへ移動ボタン
            Visibility(
              visible: place.isWorshipCardWeb,
              child: Expanded(
                  flex: 3,
                  child: ElevatedButton(
                      onPressed: () {
                        OpenAnotherUrlService.openUrl(place.worshipUrl);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.output, color: Colors.black),
                          Text('別サイトへ', style: TextStyle(color: Colors.black)),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
