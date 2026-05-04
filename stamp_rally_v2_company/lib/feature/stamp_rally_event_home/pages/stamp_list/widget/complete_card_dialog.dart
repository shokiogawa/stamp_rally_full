import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/@module/complete_card/model/complete_card_local_model.dart';
import 'package:stamp_rally_v2_fvm/core/extention/gloabal_key.extention.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/stapm_rally_event_detail_notifier.dart';
import 'package:stamp_rally_v2_fvm/core/service/open_another_url_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/complete_card_notifier.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/provider/complete_card_file_notifier.dart';
import 'package:stamp_rally_v2_fvm/gen/assets.gen.dart';

void showCompleteCardDialog(
    BuildContext context, String eventCode, String completeCardUrl) {
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
                    final async = ref.watch(completeCardNotifierProvider(
                        '$completeCardUrl/data/complete_card.csv'));

                    return switch (async) {
                      AsyncData(:final value) => _CompleteCard(
                          globalKey: globalKey,
                          value,
                          eventCode,
                          completeCardUrl),
                      // SizedBox(
                      //     // height: MediaQuery.of(context).size.height,
                      //     child: Column(
                      //       children: [
                      //         // 完了カードの表示
                      //         Expanded(
                      //             flex: 10,
                      //             child: _CompleteCard(
                      //                 globalKey: globalKey, value, eventCode)),
                      //         // アルバムに保存ボタン
                      //         // Expanded(
                      //         //     flex: 1,
                      //         //     child: _CompleteButton(
                      //         //       globalKey: globalKey,
                      //         //       eventCode: eventCode,
                      //         //     ))
                      //       ],
                      //     ),
                      //   ),
                      AsyncError(:final error) => const Center(
                          child: Text("スタンプラリー達成おめでとうございます！\n"
                              "達成カードの取得に失敗しました。\n"
                              "時間をおいて再度お試しください。")),
                      _ => Container(),
                    };
                  },
                )),
          ),
        );
      });
}

class _CompleteCard extends HookConsumerWidget {
  final GlobalKey globalKey;

  final CompleteCardLocalModel? completeCard;
  final String eventCode;
  final String completeCardUrl;

  const _CompleteCard(this.completeCard, this.eventCode, this.completeCardUrl,
      {super.key, required this.globalKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = completeCard?.title ?? "おめでとう";
    return RepaintBoundary(
      key: globalKey,
      child: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: const Color(0xFFF3CCFF),
            child: Column(
              children: [
                // 上の画像。
                Expanded(
                    flex: 6,
                    child: CachedNetworkImage(
                        imageUrl:
                            "$completeCardUrl/image/complete_card_up.png")),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: getFontSizeByLength(title),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                    child: Assets.images.conguraturation.image(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      DateFormat('yyyy年MM月dd日 HH:mm').format(
                          completeCard?.completeDateTime ?? DateTime.now()),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                completeCard?.message ?? "おめでとう",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Assets.images.completeCardSign.image(),
                            ))
                      ],
                    ),
                  ),
                )
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
      {super.key, required this.eventCode, required this.globalKey});

  final GlobalKey globalKey;
  final String eventCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stampRallyEventDetailNotifier =
        ref.watch(stampRallyEventDetailNotifierProvider(eventCode).notifier);
    final completeCardNotifier =
        ref.watch(completeCardFileNotifierProvider(eventCode).notifier);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007B43),
              side: const BorderSide(
                color: Color(0xFF007B43),
              ),
            ),
            onPressed: () async {
              // スナックバーを出す処理
              await LoadingAction.showSnackBar(
                  future: () async {
                    // widgetを画像化
                    final pngBytes = await globalKey.createWidgetImage();

                    // // 結果を保存
                    // await ImageGallerySaver.saveImage(quality: 100, pngBytes);
                    await stampRallyEventDetailNotifier.completeStampRally();

                    await completeCardNotifier.registerCompleteCard(
                        pngBytes, eventCode);

                    // // 1秒後にダイアログを出す。
                    Future.delayed(const Duration(microseconds: 500), () {
                      if (context.mounted) {
                        context.pop();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("達成カードをアルバムに保存しました！"),
                                content: const Text(
                                    "よろしければ、アプリのフィードバックをメールで送ってください。"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: Colors.green),
                                    child: const Text(
                                      "戻る",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await OpenAnotherUrlService.openEmail();
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.green),
                                    child: const Text(
                                      "送る",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    });
                  },
                  context: context,
                  successMessage: "保存に成功しました。",
                  errorMessage: "保存に失敗しました。再度やり直してください。",
                  showSuccessSnackBar: false);
            },
            child: const Text(
              "達成カードを保存する",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}

double getFontSizeByLength(String text) {
  // 150文字が上限
  final double textSize = text.length > 100
      ? 10
      : text.length > 60
          ? 12
          : 15;
  return textSize;
}
