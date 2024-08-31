import 'package:flutter/material.dart';
import 'package:taskpro/Model/model.dart';
import 'package:taskpro/widgets/Profilewidgets/profilewidgets.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Profilescreen extends StatefulWidget {
  final Modelclass usermodel;
  final String tag;
  const Profilescreen({super.key, required this.usermodel, required this.tag});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

final Profilewidgets profilewidgets = Profilewidgets();

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: body(context, widget.tag, widget.usermodel));
  }
}

Widget body(BuildContext context, String tag, Modelclass usermodel) {
  return SingleChildScrollView(
      child: Column(children: [
    profilewidgets.profileimageofworker(tag, context, usermodel),
    const SizedBox(height: 40),
    Customtext(
        text: usermodel.worktype, fontsize: 20, fontWeight: FontWeight.bold),
    const SizedBox(height: 20),
    SizedBox(width: 340, child: Customtext(text: usermodel.about)),
    const SizedBox(height: 20),
    profilewidgets.editdetailsofworkers(usermodel),
    // detailsofworkers(usermodel),
    const SizedBox(height: 20),
    profilewidgets.accountstatus(usermodel, context),
    const SizedBox(height: 20)
  ]));
}
