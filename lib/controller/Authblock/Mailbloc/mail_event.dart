part of 'mail_bloc.dart';

@immutable
sealed class MailEvent {}

class ChekEmailverrification extends MailEvent {}

class StartedEmailverrification extends MailEvent {}

class ResendEmailverrification extends MailEvent {}
