import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class RaisedPRContainer extends StatefulWidget {
  const RaisedPRContainer({super.key});

  @override
  State<RaisedPRContainer> createState() => _RaisedPRContainerState();
}

class _RaisedPRContainerState extends State<RaisedPRContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: midGreyColor, borderRadius: BorderRadius.circular(25)),
    );
  }
}
