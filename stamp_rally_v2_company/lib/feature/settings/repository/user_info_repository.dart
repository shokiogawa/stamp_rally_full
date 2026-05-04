import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_repository.g.dart';

@Riverpod(keepAlive: true)
UserInfoRepository userInfoRepository(UserInfoRepositoryRef ref) {
  return UserInfoRepository(ref);
}

class UserInfoRepository {
  const UserInfoRepository(this.ref);

  final Ref ref;

  Future<void> create() async {}

  Future<void> update() async {}
}