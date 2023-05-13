import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeText extends StatelessWidget {
  final String text;
  const CodeText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = GoogleFonts.nanumGothicCoding(color: Colors.white);
    return Text(
      text,
      style: textStyle,
    );
  }
}
