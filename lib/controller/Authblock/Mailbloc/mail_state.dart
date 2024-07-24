part of 'mail_bloc.dart';

@immutable
sealed class MailState {}

final class MailInitial extends MailState {}

final class MailLoading extends MailState {}

final class MailSuccess extends MailState {}

final class Mailresend extends MailState {}

final class Mailfialed extends MailState {}

class MailError extends MailState {
  final String error;
  MailError(this.error);
}
