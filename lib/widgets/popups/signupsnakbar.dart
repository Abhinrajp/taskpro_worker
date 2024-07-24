import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taskpro/const.dart';

class CustomPopups {
  static void authenticationresultsnakbar(
      BuildContext context, String message, Color bgcolor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          backgroundColor: bgcolor,
          duration: const Duration(seconds: 6),
          behavior: SnackBarBehavior.floating,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }

  void alertboxforconfirmation(BuildContext context, Function fun) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: primarycolour,
        title: const Text(
          'Are you sure',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: const Text('Do you want to Logout ?',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                log('logout clicked on the lerbox');
                fun();
              },
              child: const Text('Yes')),
          ElevatedButton(
              onPressed: () {
                log("clicked");
                Navigator.pop(context);
              },
              child: const Text('No')),
        ],
      ),
    );
  }
}
