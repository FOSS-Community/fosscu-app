import 'package:flutter/material.dart';

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
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
