import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_list/stamp_rally_event_list.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});

  static String get pageName => 'start_up';

  static String get pagePath => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authUseCase = ref.watch(authUseCaseProvider.notifier);
    Future(() async {
      if (context.mounted) {
        StampRallyEventListPage.pushReplacement(context);
      }
    });

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
              // alignment: Alignment.center,
              child: Text('最新のバージョンがリリースされています。')),
          TextButton(
              onPressed: () {
                // const WorkspaceListPageRoute().pushReplacement(context);
              },
              child: const Text('アプリストアへ遷移する。'))
        ],
      ),
    );
  }
}
