import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'page_controller_provider.g.dart';

// PageViewのコントローラー
@riverpod
PageController pageController(Ref ref) {
  return PageController(viewportFraction: 0.85);
}
