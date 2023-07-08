import 'package:flutter/material.dart';
import 'package:fosscu_app/constants/color.dart';

class EventForm extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  const EventForm({
    required this.hintText,
    required this.icon,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
      ).copyWith(
        top: screenWidth * 0.08,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white,
              size: screenWidth * 0.04,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: brightGreyColor,
                width: 1
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.03,
              fontWeight: FontWeight.w300
            )),
      ),
    );
  }
}
