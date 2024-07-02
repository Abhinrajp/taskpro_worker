import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/widgets/signupform.dart';
import 'package:taskpro/widgets/signupformvalidations.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
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
            'Reset Password',
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
                      height: 70,
                    ),
                    SizedBox(
                        height: 170,
                        child: LottieBuilder.asset(
                          'lib/Assets/resetanimation2.json',
                        )),
                    const SizedBox(
                      height: 50,
                    ),
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
                    TextButton(
                      onPressed: () async {
                        await resetpass();
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(primarycolour),
                          fixedSize: WidgetStatePropertyAll(Size(350, 60))),
                      child: const Text(
                        'Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  resetpass() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }
}
