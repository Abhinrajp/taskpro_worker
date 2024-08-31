import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskpro/widgets/signupwidget/simmplewidget.dart';
import 'package:taskpro/wraper.dart';

class Splashscreenvideo extends StatefulWidget {
  const Splashscreenvideo({super.key});

  @override
  State<Splashscreenvideo> createState() => _SplashscreenvideoState();
}

class _SplashscreenvideoState extends State<Splashscreenvideo> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WrapperForAuthentication(),
          ));
    });

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      SizedBox(
                          height: 250,
                          child: LottieBuilder.asset(
                              'lib/Assets/qkZXRS6SLe.json',
                              fit: BoxFit.cover)),
                      const SizedBox(height: 10),
                      AnimatedOpacity(
                          opacity: opacity,
                          duration: const Duration(seconds: 3),
                          child: const Customtext(
                              text: 'Everyday Ease',
                              fontWeight: FontWeight.bold,
                              fontsize: 25))
                    ]))));
  }
}
