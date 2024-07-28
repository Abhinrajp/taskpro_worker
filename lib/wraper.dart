import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/View/Home/homebottomnavigationbar.dart';

import 'package:taskpro/View/authentication/Login/loginscreen.dart';
import 'package:taskpro/View/authentication/Signup/email_verifying.dart';

class WrapperForAuthentication extends StatefulWidget {
  const WrapperForAuthentication({super.key});

  @override
  State<WrapperForAuthentication> createState() =>
      _WrapperForAuthenticationState();
}

class _WrapperForAuthenticationState extends State<WrapperForAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.emailVerified) {
              return const Homebottomnavigationbar();
            } else {
              return const EmailVerifying();
            }
          } else {
            return const Logingscreen();
          }
        },
      ),
    );
  }
}
