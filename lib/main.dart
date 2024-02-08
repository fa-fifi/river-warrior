import 'dart:io';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:window_size/window_size.dart';

import 'river_warrior.dart';
import 'src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle(title);
    }
  }

  final game = RiverWarrior();

  runApp(MaterialApp(
    title: title,
    theme: ThemeData(useMaterial3: true),
    home: GameWidget<RiverWarrior>(
      game: game,
      backgroundBuilder: (context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
      ),
    ),
  ));
}
