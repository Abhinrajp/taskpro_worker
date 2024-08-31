import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/View/authentication/Login/loginscreen.dart';
import 'package:taskpro/Utilities/const.dart';
import 'package:taskpro/widgets/signupwidget/signupform.dart';
import 'package:taskpro/widgets/signupwidget/signupformvalidations.dart';
import 'package:taskpro/widgets/popups/signupsnakbar.dart';

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
        primarycolour,
        Colors.white,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)),
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
                    const SizedBox(height: 50),
                    Signupform(
                      controler: email,
                      validator: validateformail,
                      hinttext: 'Email',
                      icon: const Icon(Icons.email_outlined),
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(height: 30),
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
                        )),
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
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      if (!mounted) return;
      CustomPopups.authenticationresultsnakbar(
          context,
          'A Link has been sent to your mail',
          const Color.fromARGB(255, 47, 148, 232));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Logingscreen()),
          (route) => false);
    } catch (e) {
      if (!mounted) return;
      CustomPopups.authenticationresultsnakbar(
          context, 'Failed to send reset email. Please try again.', Colors.red);
    }
  }
}
