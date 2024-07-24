import 'package:flutter/material.dart';
import 'package:taskpro/Model/model.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Profilescreen extends StatelessWidget {
  final Modelclass usermodel;
  const Profilescreen({super.key, required this.usermodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.9),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: const Offset(2, 3))
              ]),
          height: 390,
          width: double.infinity,
          child: Stack(fit: StackFit.expand, children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
                child:
                    Image.network(usermodel.profileimage, fit: BoxFit.cover)),
            Positioned(
                left: 20,
                top: 50,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.5),
                      child:
                          const Icon(Icons.arrow_back, color: primarycolour)),
                ))
          ])),
      const SizedBox(height: 40),
      Customtext(
          text: usermodel.worktype, fontsize: 20, fontWeight: FontWeight.bold),
      const SizedBox(height: 20),
      SizedBox(width: 340, child: Customtext(text: usermodel.about)),
      const SizedBox(height: 20),
      Row(children: [
        Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Customtext(
                  text: usermodel.name,
                  fontWeight: FontWeight.bold,
                  fontsize: 14),
              const SizedBox(height: 10),
              SizedBox(
                  width: 340,
                  child: Customtext(
                      text: usermodel.location,
                      fontWeight: FontWeight.bold,
                      fontsize: 14)),
              const SizedBox(height: 10),
              Customtext(
                  text: usermodel.qualification,
                  fontWeight: FontWeight.bold,
                  fontsize: 14),
              const SizedBox(height: 10),
              Customtext(
                  text: usermodel.totalwork,
                  fontWeight: FontWeight.bold,
                  fontsize: 14),
            ]))
      ]),
      const SizedBox(height: 20),
      accountstatus(usermodel.register),
      const SizedBox(height: 20)
    ])));
  }

  Widget accountstatus(String status) {
    if (status == 'registerd') {
      return const Customtext(
          text: 'Your account is not Verified yet',
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontsize: 14);
    } else if (status == 'Rejected') {
      return const Column(children: [
        Customtext(
            text: 'Your account got Rejected',
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontsize: 16),
        Customtext(
            text: 'Please upload your ID proof again',
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontsize: 10)
      ]);
    } else {
      return const Customtext(text: '', fontsize: 0);
    }
  }
}
