class Game {
  final String id;
  final String title;
  final String? imageUrl;
  final List<String> platforms;

  const Game({
    required this.id,
    required this.title,
    this.imageUrl,
    this.platforms = const [],
  });
}
