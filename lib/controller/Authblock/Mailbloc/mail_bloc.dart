import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;
  MailBloc() : super(MailInitial()) {
    on<StartedEmailverrification>((event, emit) async {
      user = auth.currentUser;
      user!.sendEmailVerification();
      add(ChekEmailverrification());
    });
    on<ChekEmailverrification>(
      (event, emit) async {
        emit(MailLoading());
        user = auth.currentUser;
        await user!.reload();
        log(user.toString());
        if (user != null && user!.emailVerified) {
          timer!.cancel();
          emit(MailSuccess());
        } else {
          log('mailfailed');
          emit(Mailfialed());
          if (timer == null || !timer!.isActive) {
            timer = Timer.periodic(
              const Duration(seconds: 5),
              (timer) {
                add(ChekEmailverrification());
              },
            );
          }
        }
      },
    );
    on<ResendEmailverrification>(
      (event, emit) async {
        try {
          user = auth.currentUser;
          await user!.sendEmailVerification();
          emit(Mailresend());
        } catch (e) {
          emit(MailError(e.toString()));
        }
      },
    );
  }
  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
