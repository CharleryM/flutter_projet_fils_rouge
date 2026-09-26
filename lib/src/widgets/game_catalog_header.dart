import 'package:flutter/material.dart';

class GameCatalogHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const GameCatalogHeader({super.key, this.onProfileTap});

  static const double logoSize = 24;
  static const double logoContainerSize = logoSize + 16;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFF172332),
            borderRadius: BorderRadius.circular(10),
          ),
          child:Image.asset(
            'assets/images/rigfinder_logo.png',
            width: logoSize,
            height: logoSize,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RIGFINDER', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: .5)),
              Text('JEUX', style: TextStyle(color: Color(0xFF7D8B9D), fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.4)),
            ],
          ),
        ),
        const Icon(Icons.notifications_none_rounded, color: Color(0xFFB7C2D0), size: 21),
        const SizedBox(width: 12),
        IconButton(
          tooltip: 'Se déconnecter',
          onPressed: onProfileTap,
          icon: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(color: Color(0xFF2A4055), shape: BoxShape.circle),
            child: const Icon(Icons.person_rounded, color: Color(0xFFB9E1EA), size: 17),
          ),
        ),
      ],
    );
  }
}
