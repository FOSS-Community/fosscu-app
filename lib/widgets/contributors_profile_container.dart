import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class ContributorProfile extends StatefulWidget {
  const ContributorProfile({super.key});

  @override
  State<ContributorProfile> createState() => _ContributorProfileState();
}

class _ContributorProfileState extends State<ContributorProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: midGreyColor, borderRadius: BorderRadius.circular(25)),
    );
  }
}