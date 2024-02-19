import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:river_warrior/src/utils/helpers.dart';
import 'package:window_size/window_size.dart';

import 'river_warrior.dart';
import 'src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    if (kIsDesktop) setWindowTitle(title);
  }

  runApp(MaterialApp(
    title: title,
    theme: ThemeData(useMaterial3: true),
    home: GameWidget<RiverWarrior>.controlled(
      gameFactory: RiverWarrior.new,
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
