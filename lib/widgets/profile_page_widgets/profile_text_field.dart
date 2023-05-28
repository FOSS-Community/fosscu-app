import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class ProfileTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  const ProfileTextField({
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.02),
      child: TextField(
        controller: textEditingController,
        style: const TextStyle(color: brightGreyColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixIconColor: brightGreyColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          filled: true,
          fillColor: darkGreyColor,
          hintText: hintText,
          hintStyle: const TextStyle(color: brightGreyColor),
        ),
      ),
    );
  }
}
