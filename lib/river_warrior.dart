import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;

import 'src/pages/game.dart';
import 'src/pages/game_over.dart';
import 'src/pages/home.dart';
import 'src/pages/pause.dart';
import 'src/utils/constants.dart';

class RiverWarrior extends FlameGame with SingleGameInstance {
  // Routes
  final router = RouterComponent(initialRoute: 'home', routes: {
    'home': Route(HomePage.new),
    'game': Route(GamePage.new),
    'pause': PauseRoute(),
    'game-over': GameOverRoute(),
  });

  // Variables
  late double maxVerticalVelocity;

  // Controllers
  Color bladeColor = Colors.white;

  @override
  void onLoad() async {
    images.loadAllImages();
    addAll([router]);
    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    maxVerticalVelocity =
        sqrt(2 * (gravity.abs() + acceleration.abs()) * (size.y - objSize * 2));
    super.onGameResize(size);
  }
}
