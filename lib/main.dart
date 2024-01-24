import 'package:flame/flame.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flame/game.dart';

import 'river_warrior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();

  final game = RiverWarrior();

  runApp(GameWidget(game: game));
}
