import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenue sur RigFinder',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Connectez-vous pour retrouver vos configurations et comparer vos composants.',
          style: TextStyle(
            color: Color(0xFF667085),
            fontSize: 15,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}