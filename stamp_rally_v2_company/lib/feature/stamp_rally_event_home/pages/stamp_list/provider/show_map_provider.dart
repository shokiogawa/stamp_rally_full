import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'show_map_provider.g.dart';

@Riverpod(keepAlive: true)
class ShowMap extends _$ShowMap {
  @override
  bool build() {
    return false; // 初期状態は地図表示をオフにする
  }

  void toggleMapView() {
    state = !state; // 地図表示の状態をトグル
  }
}
