import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro/View/Home/homescreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Authblock/Mailbloc/mail_bloc.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';

class EmailVerifying extends StatefulWidget {
  const EmailVerifying({super.key});

  @override
  State<EmailVerifying> createState() => _EmailVerifyingState();
}

class _EmailVerifyingState extends State<EmailVerifying> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MailBloc, MailState>(listener: (context, state) {
      if (state is MailSuccess) {
        CustomPopups.authenticationresultsnakbar(
            context, 'Account created Successfully', primarycolour);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const Homebottomnavigationbar()),
          (route) => false,
        );
      } else if (state is MailError) {
        CustomPopups.authenticationresultsnakbar(
            context, state.error, Colors.red);
        Navigator.pop(context);
      } else if (state is Mailresend) {
        CustomPopups.authenticationresultsnakbar(
            context, 'Link resented', primarycolour);
      }
    }, builder: (context, state) {
      return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            primarycolour,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    state is MailSuccess
                        ? LottieBuilder.asset(
                            'lib/Assets/Account-created-animation.json')
                        : Image.asset('lib/Assets/emailsendnew-animation.gif'),
                    TextButton(
                        style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(5),
                            backgroundColor:
                                WidgetStatePropertyAll(primarycolour)),
                        onPressed: () {
                          context
                              .read<MailBloc>()
                              .add(ResendEmailverrification());
                        },
                        child: const Text('Resend Link',
                            style: TextStyle(color: Colors.white)))
                  ]))));
    });
  }
}
