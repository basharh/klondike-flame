import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:klondike/klondike_game.dart';

void main() {
  final game = KlondikeGame();
  runApp(GameWidget(game: game));
}
