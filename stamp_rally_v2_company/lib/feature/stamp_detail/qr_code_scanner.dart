import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stamp_rally_v2_fvm/core/component/loading_snack_bar.dart';
import 'package:stamp_rally_v2_fvm/core/provider/stamp_rally_event/selected_event_provider.dart';
import 'package:stamp_rally_v2_fvm/core/router/router.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/provider/stamp_detail_notifier.dart';

class QrCodeScannerScreen extends HookConsumerWidget {
  final String placeId;

  // 詳細ページをスタック
  static void push(BuildContext context, String placeId) {
    QrCodeScannerScreenRoute(placeId: placeId).push(context);
  }

  // 全てをページを置き換え
  static void go(BuildContext context, String placeId) {
    QrCodeScannerScreenRoute(placeId: placeId).go(context);
  }

  const QrCodeScannerScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);
    final eventCode = selectedEvent?.eventCode ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QRコードを読み取ってください",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Builder(
        builder: (context) => Stack(
          children: [
            MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.noDuplicates,
              ),
              fit: BoxFit.contain,
              onDetect: (capture) async {
                if (capture.barcodes.isEmpty) return;

                final historicSpotIdInQR = capture.barcodes.first.rawValue;
                if (historicSpotIdInQR == null) return;

                await LoadingAction.showSnackBar(
                    future: () async {
                      await ref
                          .watch(stampDetailNotifierProvider(placeId, eventCode)
                              .notifier)
                          .registerStampForQR(historicSpotIdInQR, eventCode);
                    },
                    context: context,
                    successMessage: "スタンプ取得しました",
                    errorMessage: "",
                    showSuccessSnackBar: true,
                    onSucess: () async {
                      // 基本別画面から遷移されてくるので、成功後戻る
                      context.pop();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
