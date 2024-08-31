part of 'password_bloc.dart';

@immutable
sealed class PasswordEvent {}

class Setvisievent extends PasswordEvent {
  final bool visi;
  final bool visifi;

  Setvisievent(this.visi, this.visifi);
}
