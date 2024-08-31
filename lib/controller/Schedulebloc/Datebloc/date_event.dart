part of 'date_bloc.dart';

@immutable
sealed class DateEvent {}

class Dateseletedevent extends DateEvent {
  final DateTime selecteddate;

  Dateseletedevent(this.selecteddate);
}

class Dateresetevent extends DateEvent {}
