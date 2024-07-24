import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customtext extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontsize;
  final Color color;

  const Customtext({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.normal,
    this.fontsize = 12,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.cabin(
          fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}
