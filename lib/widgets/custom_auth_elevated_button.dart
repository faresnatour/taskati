import 'package:flutter/material.dart';

class CustomAuthElevatedButton extends StatelessWidget {
  const CustomAuthElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff4E5AE8),
        // foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      child: Text(text, style: TextStyle(fontSize: 18)),

      onPressed: onPressed,
    );
  }
}
