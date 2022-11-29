import 'package:flutter/material.dart';

Widget defaultTextFormFiled({
  void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged,
  required String? Function(String?)? validator,
  required TextEditingController controller,
  required String label,
  required IconData? prefixIcon,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixPressed,
  required TextInputType? type,
  void Function()? onTap,

}) =>
    TextFormField(
      onTap:onTap,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: IconButton(
            onPressed: suffixPressed,
            icon: Icon(suffix),
          ),
          border: const OutlineInputBorder(),
          hintText: label),
    );