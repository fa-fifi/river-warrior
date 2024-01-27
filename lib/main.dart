import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:window_size/window_size.dart';

import 'river_warrior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  setWindowTitle('River Warrior');

  final game = RiverWarrior();

  runApp(GameWidget(
    game: game,
    backgroundBuilder: (context) => Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
      ),
    ),
  ));
}
