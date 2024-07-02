part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class Selectedprifileimageevent extends ImageEvent {
  final XFile? image;

  Selectedprifileimageevent({this.image});
}

class Selectedaadharfrontimageevent extends ImageEvent {
  final XFile? image;
  Selectedaadharfrontimageevent({this.image});
}

class Selectedaadharbackimageevent extends ImageEvent {
  final XFile? image;
  Selectedaadharbackimageevent({this.image});
}
