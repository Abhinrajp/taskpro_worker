import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(DateInitial()) {
    on<Dateseletedevent>((event, emit) {
      emit(Dateselectedstate(event.selecteddate));
    });
  }
}
