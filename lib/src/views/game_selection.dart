import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import '../widgets/game_catalog_header.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  static const games = <Game>[
    Game(
      id: 'cyberpunk-2077',
      title: 'Cyberpunk 2077',
      genre: 'RPG',
      description: 'Ray tracing et VRAM lourde',
      tags: ['RPG', 'DLSS 3.5'],
      performance: 'Ultra',
      hardware: 'GPU prioritaire',
      coverColor: Color(0xFF164A65),
    ),
    Game(
      id: 'cs2',
      title: 'CS2 / Valorant',
      genre: 'FPS compétitif',
      description: 'Puissance CPU monocœur et faible latence',
      tags: ['360 Hz ready', 'Low latency'],
      performance: 'Compétitif',
      hardware: 'CPU monocœur',
      coverColor: Color(0xFF2D596B),
    ),
    Game(
      id: 'gta-vi',
      title: 'Grand Theft Auto VI',
      genre: 'Open world',
      description: 'Équilibre CPU et GPU multicœur',
      tags: ['Next-gen', 'Prévu 2025'],
      performance: 'Élevée',
      hardware: '8 cœurs minimum',
      coverColor: Color(0xFF6C3D6F),
    ),
    Game(
      id: 'black-myth-wukong',
      title: 'Black Myth: Wukong',
      genre: 'Action RPG',
      description: 'Forte charge GPU et shaders complexes',
      tags: ['Unreal Engine 5', 'Ray tracing'],
      performance: 'Très élevée',
      hardware: 'VRAM 12 Go+',
      coverColor: Color(0xFF624232),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EEE8),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 420,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1723),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: GameCatalogHeader(),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                    children: [
                      const Text(
                        'ÉTAPE 1 • CATALOGUE DE JEUX',
                        style: TextStyle(
                          color: Color(0xFF52E0EE),
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Quels sont tes jeux favoris ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Sélectionne tes genres de prédilection et tes jeux cibles pour calibrer le matériel idéal.',
                        style: TextStyle(
                          color: Color(0xFFBBC7D3),
                          fontSize: 11,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un jeu',
                          prefixIcon: Icon(Icons.search_rounded),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'GENRES & INTENSITÉ',
                        style: TextStyle(
                          color: Color(0xFFB8C5D2),
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
                          _StaticFilter(label: 'Tous', selected: true),
                          _StaticFilter(label: 'FPS compétitif'),
                          _StaticFilter(label: 'RPG'),
                          _StaticFilter(label: 'Open world'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'TITRES POPULAIRES CALIBRÉS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .7,
                        ),
                      ),
                      const SizedBox(height: 9),
                      ...games.map(
                        (game) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GameCard(
                            game: game,
                            selected: false,
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StaticFilter extends StatelessWidget {
  final String label;
  final bool selected;

  const _StaticFilter({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: null,
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF07141D) : const Color(0xFFB5C2D0),
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
      backgroundColor: const Color(0xFF182432),
      selectedColor: const Color(0xFF52E0EE),
      side: BorderSide.none,
    );
  }
}
