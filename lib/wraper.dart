import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/View/Home/homescreen.dart';
import 'package:taskpro/View/authentication/Signup/signupscreen.dart';

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
            return const Homescreen();
          } else {
            return const SignUpScreen();
          }
        },
      ),
    );
  }
}
