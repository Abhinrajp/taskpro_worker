import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordInitial(false, true)) {
    on<Setvisievent>((event, emit) {
      emit(PasswordInitial(event.visi, event.visifi));
    });
  }
}
