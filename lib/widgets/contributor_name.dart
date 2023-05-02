import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContributorName extends StatelessWidget {
  final String contributor;
  const ContributorName({required this.contributor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Text(
        contributor,
        style: GoogleFonts.leagueSpartan(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
