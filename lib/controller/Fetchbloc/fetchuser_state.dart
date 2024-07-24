part of 'fetchuser_bloc.dart';

@immutable
sealed class FetchuserState {}

final class FetchuserInitial extends FetchuserState {}

final class FetchuserLoading extends FetchuserState {}

final class FetchuserLoaded extends FetchuserState {
  final Modelclass userdata;

  FetchuserLoaded({required this.userdata});
}

final class FetchuserError extends FetchuserState {
  final String error;

  FetchuserError(this.error);
}
