import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stamp_rally_v2_fvm/core/@module/place/model/place_model.dart';
import 'package:stamp_rally_v2_fvm/core/provider/place/fetch_place_and_stamped_provider.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/page_controller_provider.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_detail/stamp_detail.dart';
import 'package:stamp_rally_v2_fvm/feature/stamp_rally_event_home/pages/stamp_list/provider/show_map_provider.dart';

class GoogleMapPage extends HookConsumerWidget {
  const GoogleMapPage({super.key, required this.eventCode});
  final String eventCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useState<GoogleMapController?>(null);
    final placeAsync = ref.watch(fetchPlaceAndStampedProvider(eventCode));
    // final currentLocation = ref.watch(fetchCurrentLocationProvider);

    final selectedPlacetate = useState<PlaceModel?>(null);
    final showMapNotifier = ref.watch(showMapProvider.notifier);

    return placeAsync.when(
      data: (places) {
        selectedPlacetate.value = places.isNotEmpty ? places[0] : null;
        Set<Marker> markers = places.map<Marker>((place) {
          return Marker(
            markerId: MarkerId(place.historicSpotId.toString()),
            position: LatLng(place.latitude, place.longitude),
            infoWindow: InfoWindow(title: place.name),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            onTap: () {},
          );
        }).toSet();

        return Stack(children: [
          // 【GoogleMapの表示】
          GoogleMap(
            onMapCreated: (controller) {
              mapController.value = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(places[0].latitude, places[0].longitude),
              zoom: 14.0,
            ),
            markers: markers,
          ),
          // 【カルーセル】
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.list),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F4E37),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showMapNotifier.toggleMapView();
                    },
                    label: const Text("一覧表示"),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.textScalerOf(context).scale(230),
                    child: PageView.builder(
                        controller: ref.watch(pageControllerProvider),
                        onPageChanged: (int index) async {
                          mapController.value?.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(places[index].latitude,
                                  places[index].longitude),
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data = places[index];
                          // 以下のChargerCardコンポーネントに情報をprovider。
                          // overrideしない場合、エラーになるので注意。
                          return SizedBox(
                            child: _StampDetailCard(
                              place: data,
                            ),
                          );
                        }))
              ],
            ),
          ),
        ]);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
    );
  }
}

// スタンプの詳細カード
class _StampDetailCard extends StatelessWidget {
  final PlaceModel place;

  const _StampDetailCard({
    required this.place,
  });

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
                    Image.asset(
                      'assets/images/oshiyama.jpg',
                      height: 90,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                Text(place.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                    "おしやま公園は自然豊かな公園で、家族連れや観光客に人気のスポットです。春には桜が咲き誇り、ピクニックにも最適です。",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
