import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberText extends StatelessWidget {
  final String text;
  const MemberText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        style: GoogleFonts.leagueSpartan(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.04
        ),
      ),
    );
  }
}
