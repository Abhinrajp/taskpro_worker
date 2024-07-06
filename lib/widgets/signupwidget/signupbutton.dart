import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpro/Screens/authentication/Signup/signupscreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_bloc.dart';
import 'package:taskpro/controller/Authblock/Authbloc/auth_event.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupsnakbar.dart';

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
              email: utilities.email.text,
              password: utilities.password.text,
              firstName: utilities.firrstname.text,
              lastName: utilities.lastname.text,
              phoneNumber: utilities.phonenumber.text,
              location: utilities.location.text,
              maxQualification: utilities.maxqualification.text,
              workType: utilities.worktype.text,
              about: utilities.about.text,
              aadharBack: utilities.aadharback,
              aadharFront: utilities.aadharfornt,
              profileImage: utilities.profileimage));
        } else if (utilities.aadharback == null ||
            utilities.aadharfornt == null ||
            utilities.profileimage == null) {
          if (utilities.aadharback == null &&
              utilities.aadharfornt == null &&
              utilities.profileimage == null) {
            CustomSnackBar.authenticationresultsnakbar(
                context, 'Add Image details', Colors.red);
          } else if (utilities.aadharback == null ||
              utilities.aadharfornt == null) {
            CustomSnackBar.authenticationresultsnakbar(
                context, 'Add your Aadhaar details', Colors.red);
          } else {
            CustomSnackBar.authenticationresultsnakbar(
                context, 'Add your Photo', Colors.red);
          }
        }
      },
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primarycolour),
          fixedSize: WidgetStatePropertyAll(Size(400, 60))),
      child: Customtextforsignup(text: 'Sign Up', color: Colors.white),
    );
  }
}
