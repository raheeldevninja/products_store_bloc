import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
    this.text, {
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final String text;
  final bool isLoading;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.blue)
          : Text(text),
    );
  }
}
