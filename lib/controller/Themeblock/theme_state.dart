part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class Themechange extends ThemeState {
  final ThemeData themeData;

  Themechange(this.themeData);
}
