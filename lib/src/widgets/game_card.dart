import 'package:flutter/material.dart';
import '../models/game.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final bool selected;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.game,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1A202A),
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          constraints: const BoxConstraints(minHeight: 108),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border(left: BorderSide(color: selected ? const Color(0xFF52E0EE) : Colors.transparent, width: 3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                height: 92,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: game.coverColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      game.title.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 92,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(game.genre.toUpperCase(), style: const TextStyle(color: Color(0xFF52E0EE), fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: .6)),
                      const SizedBox(height: 4),
                      Text(game.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 3),
                      Text(game.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFB3BFCC), fontSize: 10)),
                      const SizedBox(height: 8),
                      Wrap(spacing: 5, children: game.tags.take(2).map((tag) => Text(tag, style: const TextStyle(color: Color(0xFF8DEEF6), fontSize: 8, fontWeight: FontWeight.w700))).toList()),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 24,
                height: 24,
                decoration: BoxDecoration(color: selected ? const Color(0xFF52E0EE) : const Color(0xFF252C36), borderRadius: BorderRadius.circular(5)),
                child: selected ? const Icon(Icons.check_rounded, color: Color(0xFF07141D), size: 19) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
