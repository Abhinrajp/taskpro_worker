import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:taskpro/Utilities/const.dart';

class Alertmessages {
  successmsg(
      BuildContext context, QuickAlertType type, String msg, Color color) {
    QuickAlert.show(
      context: context,
      type: type,
      text: msg,
      headerBackgroundColor: color,
      confirmBtnColor: primarycolour,
    );
  }
}
