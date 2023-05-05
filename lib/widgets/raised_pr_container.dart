import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fosscu_app/constants/color.dart';
import 'package:fosscu_app/constants/svg.dart';

class RaisedPRContainer extends StatefulWidget {
  const RaisedPRContainer({super.key});

  @override
  State<RaisedPRContainer> createState() => _RaisedPRContainerState();
}

class _RaisedPRContainerState extends State<RaisedPRContainer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
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
              child: SvgPicture.asset(cross, height: screenWidth * 0.1, width:  screenWidth * 0.1,),
            ),
          )
        ],
      ),
    );
  }
}
