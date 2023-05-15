import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeText extends StatelessWidget {
  final String text;
  const CodeText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle textStyle = GoogleFonts.nanumGothicCoding(color: yellowColor);
    return Container(
      alignment: AlignmentDirectional(-1, 0),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
