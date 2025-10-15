import 'package:flutter/material.dart';

class Releases extends StatelessWidget {
  const Releases({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1D0E44),
      child: Center(
        child: Text(
          "Lançamentos",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}