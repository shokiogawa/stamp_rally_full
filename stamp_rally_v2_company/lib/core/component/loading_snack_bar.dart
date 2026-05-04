import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';

class LoadingAction {
  static Future<void> showSnackBar(
      {required Future<void> Function() future,
      required BuildContext context,
      required String successMessage,
      required String errorMessage,
      required bool showSuccessSnackBar,
      Future<void> Function()? onSucess,
      Future<void> Function()? onError}) async {
    try {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration.zero,
        // これを入れると遅延を入れなくて
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await future();
      // Widgetがツリーに存在する場合に
      if (context.mounted) {
        if (showSuccessSnackBar) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  Text(
                    successMessage,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              behavior: SnackBarBehavior.floating));
        }
      }
      if (context.mounted) {
        context.pop();
      }

      if (onSucess != null) {
        await onSucess();
      }
    } catch (e) {
      // Widgetがツリーに存在する場合に
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: const EdgeInsets.all(3.0),
              leading: const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              title: Text(
                errorMessage.isNotEmpty
                    ? errorMessage
                    : e.toString().replaceFirst('Exception: ', ''),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            behavior: SnackBarBehavior.floating));
      }
      if (context.mounted) {
        context.pop();
      }

      if (onError != null) {
        await onError();
      }
    } finally {}
  }
}
