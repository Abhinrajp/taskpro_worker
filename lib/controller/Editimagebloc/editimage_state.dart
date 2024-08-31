part of 'editimage_bloc.dart';

@immutable
sealed class EditimageState {}

final class EditimageInitial extends EditimageState {}

final class Editedmagestate extends EditimageState {
  final String image;

  Editedmagestate({required this.image});
}

final class Editedfrontmagestate extends EditimageState {
  final String image;

  Editedfrontmagestate({required this.image});
}

final class Editedbackmagestate extends EditimageState {
  final String image;

  Editedbackmagestate({required this.image});
}
