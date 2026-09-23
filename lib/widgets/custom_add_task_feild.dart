import 'package:flutter/material.dart';

class CustomAddTaskFeild extends StatelessWidget {
  const CustomAddTaskFeild({
    super.key,
    this.controller,
    this.readOnly,
    this.maxLines = 1,
    required this.hintText,
    this.suffixIcon,
    this.validator,
  });
  final TextEditingController? controller;
  final bool? readOnly;
  final int maxLines;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "this feild is required";
            }
          },
      controller: controller,
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff4E5AE8)),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
