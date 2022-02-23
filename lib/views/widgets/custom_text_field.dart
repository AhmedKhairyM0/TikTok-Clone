import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: kTextStyleNormal,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
      ),
      cursorColor: kButtonColor,
      obscureText: hint == 'Password',
      validator: validator,
    );
  }
}
