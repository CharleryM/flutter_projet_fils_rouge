import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import '../widgets/game_catalog_header.dart';
import 'login.dart';

class GameSelectionPage extends StatefulWidget {
  const GameSelectionPage({super.key});

  @override
  State<GameSelectionPage> createState() => _GameSelectionPageState();
}

class _GameSelectionPageState extends State<GameSelectionPage> {
  static const _allFilter = 'Tous';

  final _searchController = TextEditingController();
  final Set<String> _selectedGameIds = <String>{};
  String _selectedFilter = _allFilter;
  String _searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Game> get _visibleGames {
    final query = _searchQuery.trim().toLowerCase();
    return games.where((game) {
      final matchesFilter = _selectedFilter == _allFilter || game.genre == _selectedFilter;
      final matchesSearch = query.isEmpty ||
          game.title.toLowerCase().contains(query) ||
          game.genre.toLowerCase().contains(query) ||
          game.tags.any((tag) => tag.toLowerCase().contains(query));
      return matchesFilter && matchesSearch;
    }).toList();
  }

  void _toggleGame(Game game) {
    setState(() {
      if (!_selectedGameIds.add(game.id)) {
        _selectedGameIds.remove(game.id);
      }
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) {
      return;
    }

    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

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
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 14, 16, 0),
                  child: GameCatalogHeader(onProfileTap: _signOut),
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
                      TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() => _searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Rechercher un jeu',
                          prefixIcon: Icon(Icons.search_rounded),
                          suffixIcon: _searchQuery.isEmpty
                              ? null
                              : IconButton(
                                  tooltip: 'Effacer la recherche',
                                  icon: const Icon(Icons.clear_rounded),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                ),
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
                      Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [_allFilter, 'FPS compétitif', 'RPG', 'Open world']
                            .map(
                              (filter) => _GameFilter(
                                label: filter,
                                selected: _selectedFilter == filter,
                                onSelected: () => setState(() => _selectedFilter = filter),
                              ),
                            )
                            .toList(),
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
                      if (_visibleGames.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: Center(
                            child: Text(
                              'Aucun jeu trouvé',
                              style: TextStyle(color: Color(0xFFB8C5D2)),
                            ),
                          ),
                        ),
                      ..._visibleGames.map(
                        (game) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GameCard(
                            game: game,
                            selected: _selectedGameIds.contains(game.id),
                            onTap: () => _toggleGame(game),
                          ),
                        ),
                      ),
                      if (_selectedGameIds.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${_selectedGameIds.length} jeu${_selectedGameIds.length > 1 ? 'x' : ''} sélectionné${_selectedGameIds.length > 1 ? 's' : ''}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF52E0EE),
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
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

class _GameFilter extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _GameFilter({required this.label, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      labelStyle: TextStyle(
        color: selected ? const Color(0xFF07141D) : const Color(0xFFB5C2D0),
        fontSize: 11,
        fontWeight: FontWeight.w800,
      ),
      backgroundColor: const Color(0xFF182432),
      selectedColor: const Color(0xFF52E0EE),
      side: BorderSide.none,
      showCheckmark: false,
    );
  }
}
