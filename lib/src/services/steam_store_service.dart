import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game.dart';

class SteamStoreService {
  SteamStoreService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<Game>> searchGames(String query) async {
    final uri = Uri.https('store.steampowered.com', '/api/storesearch/', {
      'term': query,
      'l': 'french',
      'cc': 'FR',
    });
    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 12));

    if (response.statusCode != 200) {
      throw SteamStoreException(
        'Steam a répondu avec le code ${response.statusCode}.',
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic> || decoded['items'] is! List) {
      throw const SteamStoreException(
        'La réponse du catalogue Steam est invalide.',
      );
    }

    return (decoded['items'] as List)
        .whereType<Map<String, dynamic>>()
        .where(
          (item) =>
              item['type'] == 'app' &&
              item['id'] != null &&
              item['name'] is String,
        )
        .map((item) {
          final platformsData = item['platforms'];
          final platforms = platformsData is Map<String, dynamic>
              ? platformsData.entries
                    .where((entry) => entry.value == true)
                    .map((entry) => _platformName(entry.key))
                    .toList()
              : <String>[];

          return Game(
            id: item['id'].toString(),
            title: item['name'] as String,
            imageUrl: item['tiny_image'] as String?,
            platforms: platforms,
          );
        })
        .toList();
  }

  void dispose() => _client.close();

  String _platformName(String platform) => switch (platform) {
    'windows' => 'Windows',
    'mac' => 'macOS',
    'linux' => 'Linux',
    _ => platform,
  };
}

class SteamStoreException implements Exception {
  const SteamStoreException(this.message);

  final String message;

  @override
  String toString() => message;
}
