import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui' as ui;
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/service/open_another_url_service.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/fetch_current_location_provider.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/map_controller_provider.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/stamp_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/show_map_provider.dart';

class StampListMapPage extends HookConsumerWidget {
  const StampListMapPage(
      {super.key, required this.eventCode, required this.places});
  final String eventCode;
  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(fetchCurrentLocationProvider);
    final mapController = ref.watch(mapControllerProvider);
    final showMapNotifier = ref.watch(showMapProvider.notifier);
    final removedPlace = places.skip(2).toList();
    final firstPlace =
        LatLng(removedPlace[0].latitude, removedPlace[0].longitude);

    return currentLocation.when(
      data: (location) {
        final currentPosition =
            LatLng(location?.latitude ?? 0, location?.longitude ?? 0);
        return Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: firstPlace, // Use the fetched location
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'jp.co.eln',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: currentPosition,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.red,
                        size: 50,
                      ),
                      rotate: true,
                    ),
                    ...removedPlace.map<Marker>(
                      (place) => Marker(
                        width: 60.0,
                        height: 80.0,
                        point: LatLng(place.latitude, place.longitude),
                        child: Stack(
                          children: [
                            // ピンの背景
                            CustomPaint(
                              painter: PinMarkerPainter(
                                imageUrl: place.shrineImage.isNotEmpty
                                    ? place.shrineImage
                                    : null,
                                isStamped: place.isStamped,
                              ),
                              size: const Size(60.0, 80.0),
                            ),
                            // 画像部分（円形に切り取り）
                            Positioned(
                              top: 4,
                              left: 6,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: place.shrineImage.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: place.shrineImage,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey,
                                            child: const Icon(
                                              Icons.image,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: 110,
                                          width: double.infinity,
                                          child: const Icon(Icons.image),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.list),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 169, 110, 14),
                        // backgroundColor: const Color(0xFF6F4E37),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        showMapNotifier.toggleMapView();
                      },
                      label: const Text("一覧表示"),
                    ),
                  ),
                  SizedBox(
                    height: 230,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        final place = removedPlace[value];
                        mapController.move(
                          LatLng(place.latitude, place.longitude),
                          mapController.camera.zoom,
                        );
                      },
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: removedPlace.length,
                      itemBuilder: (context, index) {
                        return _StampDetailCard(
                            place: removedPlace[index], index: index);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class _StampDetailCard extends StatelessWidget {
  final PlaceModel place;
  final int index;

  const _StampDetailCard({required this.place, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        StampDetailScreen.push(context, place.historicSpotId);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    place.shrineImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: place.shrineImage,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 100,
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(border: Border.all()),
                              height: 100,
                              width: double.infinity,
                              child: const Icon(Icons.image),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(border: Border.all()),
                            height: 100,
                            width: double.infinity,
                            child: const Icon(Icons.image),
                          ),
                    if (place.isStamped)
                      Positioned.fill(
                        top: 0,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              'assets/images/stamp.png',
                              fit: BoxFit.contain,
                              width: 50,
                              height: 50,
                            )),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('${index + 1}. ${place.name}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                // 現在地からの距離を表示
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                        flex: 1,
                        child: Icon(Icons.directions_walk,
                            color: Colors.grey, size: 16)),
                    Expanded(
                        flex: 10,
                        child: Text(
                          "現在地から ${(place.distanceFromCurrent / 1000).toStringAsFixed(1)}km",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),

                if (place.url.isNotEmpty)
                  GestureDetector(
                    onTap: () async {
                      OpenAnotherUrlService.openUrl(place.url);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.open_in_new,
                                color: Colors.blue, size: 14)),
                        Expanded(
                            flex: 10,
                            child: Text(
                              "詳細を見る",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ))
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: const Text(
                      "© OpenStreetMap contributors",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    onTap: () {
                      OpenAnotherUrlService.openUrl(
                          "https://www.openstreetmap.org/copyright");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ピン型マーカーのペインタ
class PinMarkerPainter extends CustomPainter {
  PinMarkerPainter({
    this.imageUrl,
    required this.isStamped,
  });

  final String? imageUrl;
  final bool isStamped;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isStamped ? const Color(0xFFC73A2A) : const Color(0xFF8B4513)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // ピンの影（下側）
    final shadowPath = ui.Path();
    shadowPath.moveTo(size.width * 0.5, size.height * 0.95);
    shadowPath.lineTo(size.width * 0.4, size.height * 0.75);
    shadowPath.lineTo(size.width * 0.6, size.height * 0.75);
    shadowPath.close();
    canvas.drawPath(shadowPath, shadowPaint);

    // ピンの本体（円形部分）- 上部に配置
    final center = Offset(size.width * 0.5, size.height * 0.35);
    final radius = size.width * 0.45;
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius, strokePaint);

    // ピンの先端（三角形）- 尖っている部分を下向き
    final pinPath = ui.Path();
    pinPath.moveTo(size.width * 0.5, size.height * 0.9); // 尖っている部分を下に
    pinPath.lineTo(size.width * 0.4, size.height * 0.7); // 左の角
    pinPath.lineTo(size.width * 0.6, size.height * 0.7); // 右の角
    pinPath.close();
    canvas.drawPath(pinPath, paint);
    canvas.drawPath(pinPath, strokePaint);

    // スタンプ済みの場合はチェックマークを表示
    if (isStamped) {
      final checkPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round;
      final checkPath = ui.Path();
      checkPath.moveTo(center.dx - radius * 0.3, center.dy);
      checkPath.lineTo(center.dx - radius * 0.1, center.dy + radius * 0.2);
      checkPath.lineTo(center.dx + radius * 0.3, center.dy - radius * 0.2);
      canvas.drawPath(checkPath, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is PinMarkerPainter) {
      return oldDelegate.imageUrl != imageUrl ||
          oldDelegate.isStamped != isStamped;
    }
    return true;
  }
}
