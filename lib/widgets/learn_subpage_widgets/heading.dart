import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnPageHeading extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const LearnPageHeading({
    required this.size,
    required this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle textStyle = GoogleFonts.leagueSpartan(color: color, fontSize: screenWidth * size, fontWeight: FontWeight.bold);
    return Container(
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: const AlignmentDirectional(-1, 0),
      padding: EdgeInsets.all(screenWidth * 0.03),
      margin: EdgeInsets.all(screenWidth * 0.03).copyWith(left: screenWidth * 0.04),
      child: Text(text, style: textStyle,),
    );
  }
}
