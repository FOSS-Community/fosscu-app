import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class MergedPRContainer extends StatefulWidget {
  const MergedPRContainer({super.key});

  @override
  State<MergedPRContainer> createState() => _MergedPRContainerState();
}

class _MergedPRContainerState extends State<MergedPRContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: midGreyColor, borderRadius: BorderRadius.circular(25)),
    );
  }
}