part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

class Profileimageselected extends ImageState {
  final File imagefile;
  Profileimageselected(this.imagefile);
}

class Aadhaarfrontimageselected extends ImageState {
  final File imagefile;
  Aadhaarfrontimageselected(this.imagefile);
}

class Aadharbackimageselected extends ImageState {
  final File imagefile;
  Aadharbackimageselected(this.imagefile);
}
