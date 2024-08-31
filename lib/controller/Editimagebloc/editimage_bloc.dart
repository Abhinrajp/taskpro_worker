import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'editimage_event.dart';
part 'editimage_state.dart';

class EditimageBloc extends Bloc<EditimageEvent, EditimageState> {
  EditimageBloc() : super(EditimageInitial()) {
    on<Editedimageevent>((event, emit) {
      emit(Editedmagestate(image: event.image));
    });
    on<Editedfrontimageevent>((event, emit) {
      emit(Editedfrontmagestate(image: event.image));
    });
    on<Editedbackimageevent>((event, emit) {
      emit(Editedbackmagestate(image: event.image));
    });
  }
}

class EditfrontimageBloc extends Bloc<EditimageEvent, EditimageState> {
  EditfrontimageBloc() : super(EditimageInitial()) {
    on<Editedimageevent>((event, emit) {
      emit(Editedmagestate(image: event.image));
    });
    on<Editedfrontimageevent>((event, emit) {
      emit(Editedfrontmagestate(image: event.image));
    });
    on<Editedbackimageevent>((event, emit) {
      emit(Editedbackmagestate(image: event.image));
    });
  }
}

class EditbackimageBloc extends Bloc<EditimageEvent, EditimageState> {
  EditbackimageBloc() : super(EditimageInitial()) {
    on<Editedimageevent>((event, emit) {
      emit(Editedmagestate(image: event.image));
    });
    on<Editedfrontimageevent>((event, emit) {
      emit(Editedfrontmagestate(image: event.image));
    });
    on<Editedbackimageevent>((event, emit) {
      emit(Editedbackmagestate(image: event.image));
    });
  }
}
