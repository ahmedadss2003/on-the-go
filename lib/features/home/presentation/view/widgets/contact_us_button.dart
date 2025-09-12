import 'package:flutter/material.dart';

class CustomAppBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String txt;

  const CustomAppBarButton({
    super.key,
    required this.onPressed,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // backgroundColor: const Color(0xFF1F3A5F),
          foregroundColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        child: Text(txt),
      ),
    );
  }
}
