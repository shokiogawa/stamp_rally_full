import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/usecase/auth/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'check_login_status_use_case.g.dart';

@Riverpod(keepAlive: true)
Stream<AuthState> checkLoginStatusUseCase(CheckLoginStatusUseCaseRef ref){
  return ref.read(authRepositoryProvider).checkLoginStatus();
}