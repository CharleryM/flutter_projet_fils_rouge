import 'package:flutter/material.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  static const games = [
    'Cyberpunk 2077',
    'CS2 / Valorant',
    'Grand Theft Auto VI',
    'Black Myth: Wukong',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1723),
      appBar: AppBar(
        title: const Text('Sélection de jeux'),
        backgroundColor: const Color(0xFF0D1723),
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: games.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, index) => Card(
          color: const Color(0xFF1A202A),
          child: ListTile(
            title: Text(games[index], style: const TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.check_box_outline_blank, color: Color(0xFF52E0EE)),
          ),
        ),
      ),
    );
  }
}
