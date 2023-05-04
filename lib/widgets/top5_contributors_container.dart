import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class Top5Contributors extends StatefulWidget {
  const Top5Contributors({super.key});

  @override
  State<Top5Contributors> createState() => _Top5ContributorsState();
}

class _Top5ContributorsState extends State<Top5Contributors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: midGreyColor, borderRadius: BorderRadius.circular(25)),
    );
  }
}