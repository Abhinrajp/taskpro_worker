part of 'password_bloc.dart';

@immutable
sealed class PasswordState {}

final class PasswordInitial extends PasswordState {
  final bool visi;
  final bool visifi;

  PasswordInitial(this.visi, this.visifi);
}
