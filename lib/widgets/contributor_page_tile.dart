import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContributionTile extends StatefulWidget {
  final String picture;
  final String text;
  const ContributionTile({
    required this.picture,
    required this.text,
    super.key,
  });

  @override
  State<ContributionTile> createState() => _ContributionTileState();
}

class _ContributionTileState extends State<ContributionTile> {
  bool _isTappedDown = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isTappedDown = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTappedDown = false;
        });
      },
      
           child: Container(
        width: screenWidth * 0.32,
        height: screenWidth * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: _isTappedDown? blackColor: midGreyColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 3),
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              child: SvgPicture.asset(widget.picture),
            ),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            Container(
              alignment: Alignment.center,
              width: screenWidth * 0.22,
              child: Text(
                widget.text,
                style: GoogleFonts.chivo(
                    height: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
