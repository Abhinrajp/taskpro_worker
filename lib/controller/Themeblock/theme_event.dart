part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class Toggleevent extends ThemeEvent {}

class Setthemeevent extends ThemeEvent {
  final ThemeData themeData;

  Setthemeevent(this.themeData);
}
