import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}

class LocationService {
  Future<Position?> get currentPosition async =>
      await requestPermission() ? await Geolocator.getCurrentPosition() : null;

  Future<bool> get isPermissionAllow async =>
      switch (await Geolocator.checkPermission()) {
        LocationPermission.whileInUse => true,
        LocationPermission.always => true,
        _ => false,
      };

  Future<bool> isWithinDistance(
      {required double meter, required double lat, required double lon}) async {
    final distance = await distanceFromCurrent(lat: lat, lon: lon);
    if (distance == null) {
      return false;
    }
    return distance <= meter;
  }

  Future<double?> distanceFromCurrent(
      {required double lat, required double lon}) async {
    final pos = await currentPosition;
    if (pos == null) {
      return null;
    }
    return Geolocator.distanceBetween(pos.latitude, pos.longitude, lat, lon);
  }

  Future<bool> requestPermission() async {
    if (await isPermissionAllow) {
      return true;
    }
    final permission = await Geolocator.requestPermission();
    return (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always);
  }
}
