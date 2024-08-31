import 'package:flutter/material.dart';
import 'package:taskpro/View/authentication/Signup/signupscreen.dart';
import 'package:taskpro/Utilities/const.dart';

class SplashscreenSecond extends StatelessWidget {
  const SplashscreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  'taskpro',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const Text(
                  'taskpro',
                  style: TextStyle(
                      fontSize: 20,
                      color: primarycolour,
                      fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 15),
                  child: GestureDetector(
                    child: const Text(
                      'Skip ',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                          (route) => false);
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 90,
              ),
              const SizedBox(
                width: 300,
                child: Text(
                  'Assist the client in need of your expertise',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Image.asset('lib/Assets/splashscreen2.png')
            ],
          ),
        ),
      ),
    );
  }
}
