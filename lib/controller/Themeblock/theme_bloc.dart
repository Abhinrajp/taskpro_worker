import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:taskpro/Utilities/Theme/theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(Themechange(lightmode)) {
    on<Toggleevent>((event, emit) {
      if (state is Themechange) {
        final currenttheme = (state as Themechange).themeData;
        if (currenttheme.brightness == Brightness.light) {
          emit(Themechange(darkmode));
        } else {
          emit(Themechange(lightmode));
        }
      }
    });
    on<Setthemeevent>(
      (event, emit) {
        emit(Themechange(event.themeData));
      },
    );
  }
}
