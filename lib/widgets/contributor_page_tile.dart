import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:google_fonts/google_fonts.dart';

class ContributionTile extends StatefulWidget {
  final String picture;
  final String text;
  final Widget containerToLoad;
  const ContributionTile({
    required this.containerToLoad,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.containerToLoad),
        );
      },
      child: Container(
        width: screenWidth * 0.32,
        height: screenWidth * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color:  midGreyColor,
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
