import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MergedPRContainer extends StatefulWidget {
  const MergedPRContainer({super.key});

  @override
  State<MergedPRContainer> createState() => _MergedPRContainerState();
}

class _MergedPRContainerState extends State<MergedPRContainer> {
  @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width;
   return Scaffold(
      backgroundColor: blackColor,
      body: Container(
        margin: const EdgeInsets.all(20).copyWith(top: 50),
        decoration: BoxDecoration(
          color: midGreyColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                alignment: const AlignmentDirectional(1, 1),
                child: SvgPicture.asset(
                  cross,
                  height: screenWidth * 0.1,
                  width: screenWidth * 0.1,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10).copyWith(top: 0),
                  alignment: Alignment.topLeft,
                    width: screenWidth * 0.5,
                    child: Text(
                      'Recently Merged PRs',
                      style: GoogleFonts.leagueSpartan(
                        color: purpleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.09,
                        height: 1.2,
                        decoration: null
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );

  }
}
