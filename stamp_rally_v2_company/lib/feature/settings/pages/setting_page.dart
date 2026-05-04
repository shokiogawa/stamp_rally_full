import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/feature/settings/repository/user_info_repository.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoCommand = ref.read(userInfoRepositoryProvider);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await userInfoCommand.create();
            },
            child: const Text('ユーザー情報作成')),
      ),
    );
  }
}
