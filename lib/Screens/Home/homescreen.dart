import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          signout();
          log('after logout clicked');
        },
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
