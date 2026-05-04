import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/feature/settings/repository/user_info_repository.dart';

part 'command_user_info_use_case.g.dart';

@Riverpod(keepAlive: true)
CommandUserInfoUseCase commandUserInfoUseCase(CommandUserInfoUseCaseRef ref) {
  return CommandUserInfoUseCase(ref);
}

class CommandUserInfoUseCase {
  const CommandUserInfoUseCase(this.ref);

  final Ref ref;

  UserInfoRepository get userInfoRepository =>
      ref.read(userInfoRepositoryProvider);

  Future<void> create() async {
    await userInfoRepository.create();
  }

  Future<void> update() async {
    await userInfoRepository.update();
  }
}
