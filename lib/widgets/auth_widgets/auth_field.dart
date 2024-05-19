import 'package:flutter/material.dart';
import 'package:fosscu_app/core/constants/color.dart';

class AuthField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;

  const AuthField({
    required this.icon,
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.white,
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: greenColor, width: 1),
            borderRadius: BorderRadius.circular(25)
            
          ),
          focusColor: greenColor,
          fillColor: brightGreyColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w300)
        ),
      ),
    );
  }
}
