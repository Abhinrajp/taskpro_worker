import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottombar_event.dart';
part 'bottombar_state.dart';

class BottombarBloc extends Bloc<BottombarEvent, BottombarState> {
  BottombarBloc() : super(const Bottombarindexchanged(0)) {
    on<Tabchangeevent>((event, emit) {
      emit(Bottombarindexchanged(event.index));
    });
  }
}
