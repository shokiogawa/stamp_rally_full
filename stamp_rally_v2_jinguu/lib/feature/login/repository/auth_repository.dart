import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  AuthRepository(this.client);

  final SupabaseClient client;

  // 匿名ログイン
  Future<void> signInAnonymously() async {
    final data = await client.auth.signInAnonymously();
  }

  // 現在のユーザーの確認
  bool checkIsLogin() {
    final currentUser = client.auth.currentUser;
    if (currentUser == null) {
      return false;
    }
    return true;
  }
}
