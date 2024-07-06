import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/Mapbloc/map_bloc.dart';

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
            BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                if (state.selectedlocation != null) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        context
                            .read<MapBloc>()
                            .fectplacename(state.selectedlocation!);
                        Navigator.pop(context, {
                          'location': selectedLocation,
                          'place': selectedPlace,
                        });
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
                  );
                }
                return Container();
              },
            )
          ],
        ),
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: googleplex,
                zoom: 13,
              ),
              markers: {
                if (state.selectedlocation != null)
                  Marker(
                    markerId: const MarkerId('selectedLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: state.selectedlocation!,
                  ),
              },
              onTap: (LatLng latLng) {
                context.read<MapBloc>().add(Locationselected(latLng));
              },
            );
          },
        ));
  }
}
