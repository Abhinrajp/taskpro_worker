import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapview extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const Mapview({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  _MapviewState createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {
  late GoogleMapController mapController;

  // Initial map location
  static LatLng center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: center,
          zoom: 11.0,
        ),
        onTap: handleTap,
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void handleTap(LatLng tappedPoint) {
    setState(() {
      widget.onLocationSelected(tappedPoint);
    });
  }
}
