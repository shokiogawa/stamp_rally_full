import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trigger_login_signin_provider.g.dart';

@riverpod
class TriggerLoginSignIn extends _$TriggerLoginSignIn {
  @override
  bool build() {
    return true;
  }

  void showLoginPage() {
    state = true;
  }

  void showSignInPage() {
    state = false;
  }
}
