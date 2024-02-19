import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/foundation.dart';

import 'src/pages/finish.dart';
import 'src/pages/pause.dart';
import 'src/pages/play.dart';
import 'src/pages/start.dart';

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
      router = RouterComponent(initialRoute: 'start', routes: {
        'start': Route(StartPage.new),
        'play': Route(PlayPage.new, maintainState: false),
        'pause': PauseRoute(),
        'finish': FinishRoute(),
      })
    ]);
  }
}
