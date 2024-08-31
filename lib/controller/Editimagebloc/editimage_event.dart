part of 'editimage_bloc.dart';

@immutable
sealed class EditimageEvent {}

class Editedimageevent extends EditimageEvent {
  final String image;

  Editedimageevent({required this.image});
}

class Editedfrontimageevent extends EditimageEvent {
  final String image;

  Editedfrontimageevent({required this.image});
}

class Editedbackimageevent extends EditimageEvent {
  final String image;

  Editedbackimageevent({required this.image});
}
