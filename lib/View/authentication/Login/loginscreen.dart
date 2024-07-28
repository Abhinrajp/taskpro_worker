import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskpro/View/Home/homebottomnavigationbar.dart';
import 'package:taskpro/View/authentication/Resetpassword/resetpassword.dart';
import 'package:taskpro/View/authentication/Signup/signupscreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';

class Logingscreen extends StatefulWidget {
  const Logingscreen({super.key});

  @override
  State<Logingscreen> createState() => _LogingscreenState();
}

class _LogingscreenState extends State<Logingscreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
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
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
                child: Form(
                    key: formkey,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(children: [
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            'taskpro',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                              height: 60,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 46),
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              RotateAnimatedText('    Drop all',
                                                  transitionHeight:
                                                      19 * 10 / 4),
                                              RotateAnimatedText(' Settle all',
                                                  transitionHeight:
                                                      19 * 10 / 4),
                                              RotateAnimatedText('   Manage',
                                                  transitionHeight:
                                                      19 * 10 / 4),
                                              RotateAnimatedText('   Execute',
                                                  transitionHeight:
                                                      19 * 10 / 4),
                                              RotateAnimatedText('   Clear all',
                                                  transitionHeight:
                                                      19 * 10 / 4),
                                            ],
                                            totalRepeatCount: 100,
                                            isRepeatingAnimation: true,
                                            pause: const Duration(
                                                milliseconds: 500),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 103),
                                      child: Customtext(
                                          text: 'the task',
                                          color: primarycolour,
                                          fontsize: 20,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ])),
                          const SizedBox(height: 50),
                          Signupform(
                            controler: email,
                            validator: validateformail,
                            hinttext: 'Email',
                            icon: const Icon(Icons.email_outlined),
                            textCapitalization: TextCapitalization.none,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Signupform(
                              controler: password,
                              validator: validateforpassword,
                              hinttext: 'Password',
                              textCapitalization: TextCapitalization.none,
                              icon: const Icon(Icons.remove_red_eye_outlined)),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () async {
                              log('the values are ${email.text} ${password.text}');
                              log('pressed');
                              if (formkey.currentState!.validate()) {
                                await login();
                              } else {}
                              log('after login button pressed');
                            },
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(primarycolour),
                                fixedSize:
                                    WidgetStatePropertyAll(Size(350, 60))),
                            child: const Customtext(
                                text: 'Login',
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordScreen(),
                                        ));
                                  },
                                  child: Customtext(
                                    text: 'Forget password ?',
                                    color: Colors.blueGrey.shade900,
                                    fontsize: 11,
                                    fontWeight: FontWeight.w400,
                                  ))
                            ],
                          ),
                          const SizedBox(height: 60),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Customtext(
                                    text: 'Do you have an account ?',
                                    color: Colors.blueGrey.shade900,
                                    fontsize: 12,
                                    fontWeight: FontWeight.w400),
                                const SizedBox(width: 5),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen(),
                                          ));
                                    },
                                    child: const Customtext(
                                        text: 'Sign up >',
                                        fontsize: 12,
                                        fontWeight: FontWeight.bold))
                              ])
                        ]))))));
  }

  login() async {
    if (!mounted) return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      if (!mounted) return;
      CustomPopups.authenticationresultsnakbar(
          context, 'Login Successfully', Colors.green);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => const Homebottomnavigationbar()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (!mounted) return;
      CustomPopups.authenticationresultsnakbar(
          context, 'Invalid Email or Password', Colors.red);
    } catch (e) {
      if (!mounted) return;
      CustomPopups.authenticationresultsnakbar(
          context, e.toString(), Colors.red);
    }
  }
}
