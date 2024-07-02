import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:taskpro/const.dart';

class Mapviewpage extends StatefulWidget {
  const Mapviewpage({Key? key}) : super(key: key);

  @override
  State<Mapviewpage> createState() => _MapviewpageState();
}

class _MapviewpageState extends State<Mapviewpage> {
  static const LatLng googleplex = LatLng(11.2588, 75.7804);
  LatLng? selectedLocation;
  String? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Map',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              backgroundColor: primarycolour,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          if (selectedLocation != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedLocation != null) {
                    List<geocoding.Placemark> placemarks =
                        await geocoding.placemarkFromCoordinates(
                            selectedLocation!.latitude,
                            selectedLocation!.longitude);
                    if (placemarks.isNotEmpty) {
                      geocoding.Placemark place = placemarks.first;
                      setState(() {
                        selectedPlace =
                            "${place.name}, ${place.street}, ${place.locality}, ${place.subLocality}, ${place.administrativeArea}, ${place.country}";
                      });
                    }

                    Navigator.pop(context, {
                      'location': selectedLocation,
                      'place': selectedPlace,
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: primarycolour,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: googleplex,
          zoom: 13,
        ),
        markers: {
          if (selectedLocation != null)
            Marker(
              markerId: const MarkerId('selectedLocation'),
              icon: BitmapDescriptor.defaultMarker,
              position: selectedLocation!,
            ),
        },
        onTap: (LatLng latLng) {
          setState(() {
            selectedLocation = latLng;
          });
        },
      ),
    );
  }
}
