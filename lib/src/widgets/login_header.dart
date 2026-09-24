import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/rigfinder_logo.png',
          width: 48,
          height: 48,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'RIGFINDER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: .8,
            ),
          ),
        ),
        const Icon(
          Icons.lock_outline_rounded,
          color: Color(0xFF7CE3FF),
          size: 19,
        ),
      ],
    );
  }
}
