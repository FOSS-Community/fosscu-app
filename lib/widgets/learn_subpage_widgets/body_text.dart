import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnPageBodyText extends StatelessWidget {
  final String text;
  final Color color;
  const LearnPageBodyText({
    required this.color,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle textStyle = GoogleFonts.leagueSpartan(color: color, fontSize: screenWidth * 0.04, fontWeight: FontWeight.w400, height: 1.3);
    return Container(
      decoration: BoxDecoration(
        color: darkGreyColor,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: EdgeInsets.all(screenWidth * 0.05),
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Text(text, style: textStyle,),
    );
  }
}
