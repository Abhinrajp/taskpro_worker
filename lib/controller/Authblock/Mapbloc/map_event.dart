part of 'map_bloc.dart';

@immutable
sealed class MapEvent {}

class Locationselected extends MapEvent {
  final LatLng location;

  Locationselected(this.location);
}

class Confirmlocation extends MapEvent {
  final LatLng location;
  final String place;
  Confirmlocation(this.location, this.place);
}
