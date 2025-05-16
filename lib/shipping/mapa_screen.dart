import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_ios/google_maps_flutter_ios.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  LatLng initialPosition = LatLng(19.4326, -99.1332);
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(19.4326, -99.1332),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(initialCameraPosition: initialCameraPosition),
    );
  }
}
