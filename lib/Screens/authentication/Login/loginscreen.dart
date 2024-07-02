import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskpro/Screens/authentication/Resetpassword/resetpassword.dart';
import 'package:taskpro/Screens/authentication/Signup/signupscreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupform.dart';

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
        Color.fromRGBO(17, 46, 64, 1.0),
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Login',
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'taskpro',
                    style: TextStyle(
                        color: primarycolour,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 60,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 46),
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  child: AnimatedTextKit(
                                    animatedTexts: [
                                      RotateAnimatedText('    Drop all',
                                          transitionHeight: 19 * 10 / 4),
                                      RotateAnimatedText(' Settle all',
                                          transitionHeight: 19 * 10 / 4),
                                      RotateAnimatedText('   Manage',
                                          transitionHeight: 19 * 10 / 4),
                                      RotateAnimatedText('   Execute',
                                          transitionHeight: 19 * 10 / 4),
                                      RotateAnimatedText('   Clear all',
                                          transitionHeight: 19 * 10 / 4),
                                    ],
                                    totalRepeatCount: 100,
                                    isRepeatingAnimation: true,
                                    pause: const Duration(milliseconds: 500),
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
                            child: Text(
                              'the task',
                              style: TextStyle(
                                  color: primarycolour,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Signupform(
                    controler: email,
                    valmsg: 'Enter your mail',
                    hinttext: 'Email',
                    icon: const Icon(Icons.email_outlined),
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Signupform(
                      controler: password,
                      valmsg: 'Enter your password',
                      hinttext: 'Password',
                      textCapitalization: TextCapitalization.none,
                      icon: const Icon(Icons.remove_red_eye_outlined)),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () async {
                      log('the values are ${email.text} ${password.text}');
                      log('pressed');
                      if (formkey.currentState!.validate()) {
                        await login();
                      } else {
                        print('${email.text} ${password.text}');
                      }
                      log('after login button pressed');
                    },
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primarycolour),
                        fixedSize: WidgetStatePropertyAll(Size(350, 60))),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          child: Text(
                            'Forget password ?',
                            style: TextStyle(
                                color: Colors.blueGrey[900],
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account ?',
                        style: TextStyle(
                            color: Colors.blueGrey[900],
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ));
                          },
                          child: const Text(
                            'Sign up >',
                            style: TextStyle(
                                color: Color.fromARGB(255, 4, 9, 11),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
  }
}
