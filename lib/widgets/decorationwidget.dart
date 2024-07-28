import 'package:flutter/material.dart';

class Customeanimatedcontainer extends StatelessWidget {
  const Customeanimatedcontainer(
      {super.key,
      required this.width,
      this.height = 80,
      this.borderRadius,
      this.child,
      this.color = Colors.transparent});
  final double width;
  final double height;
  final Color color;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        alignment: Alignment.center,
        child: child ?? const SizedBox());
  }
}
