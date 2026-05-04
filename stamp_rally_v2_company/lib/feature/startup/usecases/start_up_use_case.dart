import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_up_use_case.g.dart';

enum StartUpResultType {
  logIn,
  notLogin,
  forceVersionUp,
}

@riverpod
Future<StartUpResultType> startUpUseCase(StartUpUseCaseRef ref) async {
  return StartUpResultType.logIn;
}
