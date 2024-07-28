part of 'bottombar_bloc.dart';

@immutable
sealed class BottombarState {
  final int currentIndex;
  const BottombarState(this.currentIndex);
}

final class Bottombarindexchanged extends BottombarState {
  const Bottombarindexchanged(int currentindex) : super(currentindex);
}
