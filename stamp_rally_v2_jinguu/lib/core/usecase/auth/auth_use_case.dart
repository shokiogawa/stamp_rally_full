import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/usecase/auth/model/user_info.dart';
import 'package:stamp_rally_v2_fvm/core/usecase/auth/repository/auth_repository.dart';

part 'auth_use_case.g.dart';

@riverpod
class AuthUseCase extends _$AuthUseCase {
  @override
  FutureOr<UserInfo?> build() async {
    // 初期化時にユーザー情報をフェッチ
    return _fetchUserInfo();
  }

  AuthRepository get repo => ref.read(authRepositoryProvider);

  Future<UserInfo?> _fetchUserInfo() async {
    final repo = ref.read(authRepositoryProvider);
    return repo.getCurrentUser();
  }

  // ログイン後にユーザー情報を再フェッチ
  Future<void> refreshUserInfo() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchUserInfo);
  }

  Future<void> signIn(String userName, String password, String email) async {
    await repo.signUp(userName, password, email);
    ref.invalidateSelf();
  }

  Future<void> login(String password, String email) async {
    await repo.signInWithPassword(email, password);
    ref.invalidateSelf();
  }

  Future<void> signInAnonymously() async {
    await repo.signInAnonymously();
    ref.invalidateSelf();
  }

  Future<bool> isLogin() async {
    await refreshUserInfo();
    return repo.isLogin();
  }

  Future<int?> getUserId() async {
    if (state.value == null) {
      final user = await _fetchUserInfo();
      return user?.id;
    }
    return state.value?.id;
  }
}
