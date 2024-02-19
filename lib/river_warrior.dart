import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';

import 'src/pages/game.dart';
import 'src/pages/game_over.dart';
import 'src/pages/home.dart';
import 'src/pages/pause.dart';

class RiverWarrior extends FlameGame
    with SingleGameInstance, HasCollisionDetection {
  late final RouterComponent router;
  Color bladeColor = BasicPalette.white.color;
  int highScore = 0;
  int maxMistake = 3;
  double musicVolume = kIsWeb ? 0 : 1;
  double soundVolume = 1;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await images.loadAllImages();
    addAll([
      router = RouterComponent(initialRoute: 'home', routes: {
        'home': Route(HomePage.new),
        'game': Route(GamePage.new, maintainState: false),
        'pause': PauseRoute(),
        'game-over': GameOverRoute(),
      })
    ]);
  }
}
