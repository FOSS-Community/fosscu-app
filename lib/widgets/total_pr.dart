import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalPr extends StatelessWidget {
  final String totalPr;
  const TotalPr({required this.totalPr, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Total PRs = ' + totalPr,
        style: GoogleFonts.chivo(color: Colors.black),
      ),
    );
  }
}
