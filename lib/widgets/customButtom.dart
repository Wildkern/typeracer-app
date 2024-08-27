import 'package:flutter/material.dart';

class Custombuttom extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isHome;

  const Custombuttom({
    super.key,
    required this.text,
    required this.onTap,
    this.isHome = false,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
