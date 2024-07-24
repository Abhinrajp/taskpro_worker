import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
          padding: const EdgeInsets.only(top: 170),
          child: Column(
            children: [
              AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(seconds: 3),
                  child: SizedBox(
                    height: 70,
                    width: 190,
                    child: Image.asset('lib/Assets/text-1719202244246.png'),
                  )),
              const SizedBox(
                height: 60,
              ),
              LottieBuilder.asset('lib/Assets/splashscreen.json'),
            ],
          ),
        ),
      ),
    );
  }
}
