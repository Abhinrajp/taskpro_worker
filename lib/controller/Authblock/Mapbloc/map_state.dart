part of 'map_bloc.dart';

@immutable
class MapState {
  final LatLng? selectedlocation;
  final String? selectedplace;
  const MapState({this.selectedlocation, this.selectedplace});
  MapState copywith({LatLng? selectedlocaion, String? selectedplace}) {
    return MapState(
        selectedlocation: selectedlocaion ?? this.selectedlocation,
        selectedplace: selectedplace ?? this.selectedplace);
  }
}

final class MapInitial extends MapState {}
