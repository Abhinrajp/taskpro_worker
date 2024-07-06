import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<Locationselected>((event, emit) {
      emit(state.copywith(selectedlocaion: event.location));
    });
    on<Confirmlocation>((event, emit) {
      emit(state.copywith(
          selectedlocaion: event.location, selectedplace: event.place));
    });
  }

  Future<void> fectplacename(LatLng location) async {
    List<geocoding.Placemark> placemarks = await geocoding
        .placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      geocoding.Placemark place = placemarks.first;
      String selectedplace =
          "${place.name}, ${place.street}, ${place.locality}, ${place.subLocality}, ${place.administrativeArea}, ${place.country}";
      add(Confirmlocation(location, selectedplace));
    }
  }
}
