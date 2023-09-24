import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPanel extends StatefulWidget {
   double Lat;
   double Lon;
   MapPanel({required this.Lat, required this.Lon, Key? key}) : super(key: key);

  @override
  State<MapPanel> createState() => _MapPanelState();
}

class _MapPanelState extends State<MapPanel> {
  final MapController mapController = MapController();

  Position? _currentPosition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  void _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      await _getCurrentLocation();
    } else {
      setState(() {
        _currentPosition = Position(
          latitude: 41.425040,
          longitude: 22.650813,
          timestamp: DateTime.now(),
          accuracy: 100,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentPosition == null
        ? const CircularProgressIndicator()
        : Stack(children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude),
                  zoom: 13.0),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayerOptions(markers: [
                  Marker(
                    point: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    builder: (ctx) => const Icon(
                      Icons.location_history,
                      color: Colors.green,
                    ),
                  ),
                  Marker(
                    point: LatLng(widget.Lat,
                        widget.Lon),
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                  ),
                ]),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        mapController.move(
                            mapController.center, mapController.zoom + 1);
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8.0),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        mapController.move(
                            mapController.center, mapController.zoom - 1);
                      });
                    },
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ]);
  }
}
