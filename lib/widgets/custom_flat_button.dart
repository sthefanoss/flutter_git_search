import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
