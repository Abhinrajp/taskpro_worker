part of 'date_bloc.dart';

@immutable
sealed class DateState {}

final class DateInitial extends DateState {}

final class Dateselectedstate extends DateState {
  final DateTime selecteddate;

  Dateselectedstate(this.selecteddate);
}
