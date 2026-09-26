import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/game.dart';
import '../services/steam_store_service.dart';
import '../widgets/game_card.dart';
import '../widgets/game_catalog_header.dart';
import 'login.dart';

class GameSelectionPage extends StatefulWidget {
  const GameSelectionPage({super.key, this.steamStoreService});

  final SteamStoreService? steamStoreService;

  @override
  State<GameSelectionPage> createState() => _GameSelectionPageState();
}

class _GameSelectionPageState extends State<GameSelectionPage> {
  final _searchController = TextEditingController();
  final Set<String> _selectedGameIds = <String>{};
  late final SteamStoreService _steamStoreService;
  late final bool _ownsSteamStoreService;
  List<Game> _games = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? _errorMessage;
  int _searchRequestId = 0;
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    _ownsSteamStoreService = widget.steamStoreService == null;
    _steamStoreService = widget.steamStoreService ?? SteamStoreService();
  }

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    _searchController.dispose();
    if (_ownsSteamStoreService) {
      _steamStoreService.dispose();
    }
    super.dispose();
  }

  void _onSearchChanged(String value) {
    final query = value.trim();
    final requestId = ++_searchRequestId;
    _searchDebounceTimer?.cancel();

    if (query.length < 2) {
      setState(() {
        _games = [];
        _isLoading = false;
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _games = [];
      _isLoading = false;
      _errorMessage = null;
    });
    _searchDebounceTimer = Timer(
      const Duration(milliseconds: 350),
      () => _searchGames(query, requestId),
    );
  }

  Future<void> _searchGames(String query, int requestId) async {
    if (!mounted || requestId != _searchRequestId) return;
    setState(() => _isLoading = true);

    try {
      final games = await _steamStoreService.searchGames(query);
      if (!mounted || requestId != _searchRequestId) return;
      setState(() {
        _games = games;
        _isLoading = false;
      });
    } on Exception catch (error) {
      if (!mounted || requestId != _searchRequestId) return;
      setState(() {
        _isLoading = false;
        _errorMessage = error is SteamStoreException
            ? error.message
            : 'Impossible de contacter Steam. Vérifie ta connexion et réessaie.';
      });
    }
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
                        'CATALOGUE STEAM',
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
                        'Recherche un jeu dans la boutique Steam et sélectionne ceux auxquels tu veux jouer.',
                        style: TextStyle(
                          color: Color(0xFFBBC7D3),
                          fontSize: 11,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() => _searchQuery = value);
                          _onSearchChanged(value);
                        },
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
                                    _onSearchChanged('');
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'RÉSULTATS DE LA BOUTIQUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .7,
                        ),
                      ),
                      const SizedBox(height: 9),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              _errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Color(0xFFFF8D8D)),
                            ),
                          ),
                        )
                      else if (_searchQuery.trim().length < 2)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: Center(
                            child: Text(
                              'Saisis au moins deux caractères pour rechercher dans Steam.',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Color(0xFFB8C5D2)),
                            ),
                          ),
                        )
                      else if (_games.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 28),
                          child: Center(
                            child: Text(
                              'Aucun jeu trouvé',
                              style: TextStyle(color: Color(0xFFB8C5D2)),
                            ),
                          ),
                        ),
                      ..._games.map(
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
