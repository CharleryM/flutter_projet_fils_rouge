import 'package:flutter/material.dart';

class Game {
  final String id;
  final String title;
  final String genre;
  final String description;
  final List<String> tags;
  final String performance;
  final String hardware;
  final Color coverColor;

  const Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.description,
    required this.tags,
    required this.performance,
    required this.hardware,
    required this.coverColor,
  });
}
