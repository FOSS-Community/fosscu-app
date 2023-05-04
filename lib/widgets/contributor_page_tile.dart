import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class ContributionTile extends StatefulWidget {
  const ContributionTile({super.key});

  @override
  State<ContributionTile> createState() => _ContributionTileState();
}

class _ContributionTileState extends State<ContributionTile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.3,
      height: screenWidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: midGreyColor
      ),
    );
  }
}
