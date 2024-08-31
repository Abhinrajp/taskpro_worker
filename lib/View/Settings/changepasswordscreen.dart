import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';
import 'package:taskpro/Services/authservices.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/controller/Paswwordblock/password_bloc.dart';
import 'package:taskpro/widgets/changepasswidget.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Changepasswordscreen extends StatefulWidget {
  const Changepasswordscreen({super.key});

  @override
  State<Changepasswordscreen> createState() => _ChangepasswordscreenState();
}

final formkey = GlobalKey<FormState>();
final Authservices authservices = Authservices();
final oldpasscontroller = TextEditingController();
final newpasscontroller = TextEditingController();
final newpassconfirmcontroller = TextEditingController();

// final Appstatecontroller appstatecontroller = Get.find();
// final CustomPopups customPopups=CustomPopups();
class _ChangepasswordscreenState extends State<Changepasswordscreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          primarycolour,
          Colors.white,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(context),
            body: body(context)));
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white)),
      backgroundColor: Colors.transparent,
      title: const Text('Change Password',
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      centerTitle: true);
}

Widget body(BuildContext context) {
  return SingleChildScrollView(
      child: Form(
          key: formkey,
          child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(children: [
                const SizedBox(height: 70),
                SizedBox(
                    height: 170,
                    child:
                        LottieBuilder.asset('lib/Assets/resetanimation2.json')),
                const SizedBox(height: 50),
                BlocBuilder<PasswordBloc, PasswordState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Visibility(
                            visible: (state is PasswordInitial)
                                ? state.visifi
                                : true,
                            child: Customformfield(
                                controller: oldpasscontroller,
                                validator: validateforpassword,
                                hintext: 'Old password',
                                keybordtype: TextInputType.name,
                                icon: const Icon(Icons.lock_outline))),
                        Visibility(
                            visible:
                                (state is PasswordInitial) ? state.visi : false,
                            child: Column(children: [
                              const Row(children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Customtext(
                                        text: 'Add new password',
                                        fontWeight: FontWeight.bold,
                                        fontsize: 13,
                                        color: Colors.black87))
                              ]),
                              const SizedBox(height: 10),
                              Customformfield(
                                controller: newpasscontroller,
                                validator: validateforpassword,
                                hintext: 'New password',
                                keybordtype: TextInputType.name,
                                icon: const Icon(Icons.lock_outline),
                              ),
                              const SizedBox(height: 10),
                              Customformfield(
                                  controller: newpassconfirmcontroller,
                                  validator: validateforpassword,
                                  hintext: 'Confirm new password',
                                  keybordtype: TextInputType.name,
                                  icon: const Icon(Icons.lock_outline))
                            ])),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                TextButton(
                    onPressed: () async {
                      var pass = await authservices.fetchuserpass();
                      if (oldpasscontroller.text.isNotEmpty &&
                          oldpasscontroller.text == pass) {
                        context.read<PasswordBloc>().add(
                              Setvisievent(true, false),
                            );
                        log(pass);
                        if (newpasscontroller.text.isNotEmpty &&
                            newpassconfirmcontroller.text.isNotEmpty &&
                            newpasscontroller.text ==
                                newpassconfirmcontroller.text) {
                          await changepass(context, pass);
                          oldpasscontroller.clear();
                          newpasscontroller.clear();
                          newpassconfirmcontroller.clear();
                          context.read<PasswordBloc>().add(
                                Setvisievent(false, true),
                              );
                        } else {
                          CustomPopups.authenticationresultsnakbar(
                              context,
                              'Enterd the new password is not match',
                              Colors.red);
                        }
                      } else {
                        log('old pass is empty');
                        CustomPopups.authenticationresultsnakbar(context,
                            'You enterd the wrong password', Colors.red);
                      }
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primarycolour),
                        fixedSize: WidgetStatePropertyAll(Size(350, 60))),
                    child: const Text('Change',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 10)
              ]))));
}

changepass(BuildContext context, String pass) async {
  await authservices.changepassword(
      context, newpassconfirmcontroller.text, pass);
}
