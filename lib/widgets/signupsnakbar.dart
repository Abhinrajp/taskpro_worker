import 'package:flutter/material.dart';

class CustomSnackBar {
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
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
