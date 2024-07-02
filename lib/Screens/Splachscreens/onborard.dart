import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskpro/Screens/Splachscreens/splashscreenfour.dart';
import 'package:taskpro/Screens/Splachscreens/splashscreenmain.dart';
import 'package:taskpro/Screens/Splachscreens/splashscreensecond.dart';
import 'package:taskpro/Screens/Splachscreens/splashscreenthree.dart';
import 'package:taskpro/Screens/authentication/Login/loginscreen.dart';
import 'package:taskpro/const.dart';
import 'package:taskpro/wraper.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 50),
        child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                isLastPage = value == 3;
              });
            },
            children: const [
              Splachscreenmain(),
              SplashscreenSecond(),
              SplashscreenThree(),
              SplashscreenFour()
            ]),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        height: 50,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: controller,
              count: 4,
              effect: const WormEffect(
                  dotColor: Colors.grey,
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: primarycolour),
              onDotClicked: (index) => controller.animateToPage(index,
                  duration: const Duration(seconds: 1), curve: Curves.linear),
            ),
            isLastPage
                ? GestureDetector(
                    child: const Text('Sign Up >'),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const WrapperForAuthentication(),
                          ),
                          (route) => false);
                    },
                  )
                : GestureDetector(
                    child: const Text('Got it >'),
                    onTap: () {
                      controller.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
