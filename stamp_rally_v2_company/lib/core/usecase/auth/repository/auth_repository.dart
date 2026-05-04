import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/supabase_client.dart';
import 'package:stamp_rally_v2_fvm/core/usecase/auth/model/user_info.dart';
import 'package:stamp_rally_v2_fvm/core/utility/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final client = ref.read(supabaseClientProvider);
  return AuthRepository(client);
}

class AuthRepository {
  const AuthRepository(this._client);

  final SupabaseClient _client;

  // サインイン
  Future<void> signUp(String userName, String password, String email) async {
    try {
      await _client.auth.signUp(
          email: email, password: password, data: {'user_name': userName});
    } on Exception catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // サインアウト
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on Exception catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // ログイン
  Future<void> signInWithPassword(String email, String password) async {
    logger.i({'email', email, 'password', password});
    try {
      await _client.auth.signInWithPassword(password: password, email: email);
    } on AuthException catch (e) {
      logger.e(e.message);
      rethrow;
    } on Exception catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  // 匿名認証
  Future<void> signInAnonymously() async {
    try {
      final authUser = await _client.auth.signInAnonymously();
      await _client
          .from('users')
          .insert({'uid': authUser.user?.id ?? '', 'name': '匿名ユーザー'});
      logger.i(authUser);
    } on Exception catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future<UserInfo?> getCurrentUser() async {
    final currentUser = _client.auth.currentUser;
    if (currentUser == null) {
      return null;
    }

    try {
      logger.i(currentUser.id);
      final response = await _client
          .from('users')
          .select()
          .eq('uid', currentUser.id) // uidで検索
          .maybeSingle();
      return UserInfo.fromJson(response!);
    } on Exception catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  bool isLogin() {
    final currentUser = _client.auth.currentUser;
    logger.i(currentUser);
    if (currentUser == null) {
      return false;
    }
    return true;
  }

  // 現在のログイン状態の確認
  Stream<AuthState> checkLoginStatus() {
    return _client.auth.onAuthStateChange;
  }
}
