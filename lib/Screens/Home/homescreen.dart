import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/Screens/authentication/Login/loginscreen.dart';
import 'package:taskpro/widgets/signupsnakbar.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('${user!.email}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          log('logout clicked');
          signout(context, user);
          log('after logout clicked');
        },
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }

  signout(BuildContext context, User user) async {
    await FirebaseAuth.instance.signOut();
    CustomSnackBar.authenticationresultsnakbar(
        context, 'You logoutedd from ${user.displayName}', Colors.red);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const Logingscreen(),
      ),
      (route) => false,
    );
  }
}
