import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String texte;
  final IconData icon;
  final VoidCallback? onPressed;

  const CardButton({
    super.key,
    required this.texte,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(texte),
      ),
    );
  }
}
