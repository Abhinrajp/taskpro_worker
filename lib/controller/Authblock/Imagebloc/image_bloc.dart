import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<Selectedprifileimageevent>(onselectedprofileimageevent);
    on<Selectedaadharfrontimageevent>(onselectedaadharfrontimageevent);
    on<Selectedaadharbackimageevent>(onselectedaadharbackimageevent);
  }
  void onselectedprofileimageevent(
      Selectedprifileimageevent evnt, Emitter<ImageState> emit) {
    if (evnt.image != null) {
      emit(Profileimageselected(File(evnt.image!.path)));
    }
  }

  void onselectedaadharfrontimageevent(
      Selectedaadharfrontimageevent evnt, Emitter<ImageState> emit) {
    if (evnt.image != null) {
      emit(Aadhaarfrontimageselected(File(evnt.image!.path)));
    }
  }

  void onselectedaadharbackimageevent(
      Selectedaadharbackimageevent evnt, Emitter<ImageState> emit) {
    if (evnt.image != null) {
      emit(Aadharbackimageselected(File(evnt.image!.path)));
    }
  }
}
