import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnPageSubHeading extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const LearnPageSubHeading({
    required this.size,
    required this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle textStyle = GoogleFonts.leagueSpartan(color: color, fontSize: screenWidth * size, fontWeight: FontWeight.w400);
    return Container(
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(10)
      ),
      alignment: const AlignmentDirectional(-1, 0),
      padding: EdgeInsets.all(screenWidth * 0.03),
      margin: EdgeInsets.only(left: screenWidth * 0.04),
      child: Text(text, style: textStyle,),
    );
  }
}
