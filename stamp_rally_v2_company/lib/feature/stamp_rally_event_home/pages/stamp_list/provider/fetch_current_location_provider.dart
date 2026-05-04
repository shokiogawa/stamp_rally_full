import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stamp_rally_v2_fvm/core/service/location/location_service.dart';

part 'fetch_current_location_provider.g.dart';

@riverpod
Future<Position?> fetchCurrentLocation(Ref ref) async {
  final locationService = ref.read(locationServiceProvider);
  return await locationService.currentPosition;
}
