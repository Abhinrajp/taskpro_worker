import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/View/authentication/Signup/signupscreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_event.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Signupbutton extends StatelessWidget {
  const Signupbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        log(utilities.location.text);
        log('work type is ${utilities.worktype.text}');
        if (formKey.currentState!.validate() &&
            utilities.profileimage != null &&
            utilities.aadharfornt != null &&
            utilities.aadharback != null) {
          BlocProvider.of<AuthBloc>(context).add(SignUpRequested(
              email: utilities.email.text.trim(),
              password: utilities.password.text.trim(),
              firstName: utilities.firrstname.text.trim(),
              lastName: utilities.lastname.text.trim(),
              phoneNumber: utilities.phonenumber.text.trim(),
              location: utilities.location.text.trim(),
              maxQualification: utilities.maxqualification.text.trim(),
              workType: utilities.worktype.text.trim(),
              about: utilities.about.text.trim(),
              registerd: 'registerd',
              aadharBack: utilities.aadharback,
              aadharFront: utilities.aadharfornt,
              profileImage: utilities.profileimage));
        } else if (utilities.aadharback == null ||
            utilities.aadharfornt == null ||
            utilities.profileimage == null) {
          if (utilities.aadharback == null &&
              utilities.aadharfornt == null &&
              utilities.profileimage == null) {
            CustomPopups.authenticationresultsnakbar(
                context, 'Add Image details', Colors.red);
          } else if (utilities.aadharback == null ||
              utilities.aadharfornt == null) {
            CustomPopups.authenticationresultsnakbar(
                context, 'Add your Aadhaar details', Colors.red);
          } else {
            CustomPopups.authenticationresultsnakbar(
                context, 'Add your Photo', Colors.red);
          }
        }
      },
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primarycolour),
          fixedSize: WidgetStatePropertyAll(Size(400, 60))),
      child: const Customtext(text: 'Sign Up', color: Colors.white),
    );
  }
}
