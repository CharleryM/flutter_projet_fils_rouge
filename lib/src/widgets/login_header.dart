import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  static const double logoSize = 52;
  static const double logoContainerSize = logoSize + 16;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: logoContainerSize,
          height: logoContainerSize,
          decoration: BoxDecoration(
            color: const Color(0xFF1A2938),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/images/rigfinder_logo.png',
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'RIGFINDER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: .7,
            ),
          ),
        ),
      ],
    );
  }
}