part of 'bottombar_bloc.dart';

@immutable
sealed class BottombarEvent {}

class Tabchangeevent extends BottombarEvent {
  final int index;

  Tabchangeevent(this.index);
}
