import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

import 'src/pages/game.dart';
import 'src/pages/game_over.dart';
import 'src/pages/home.dart';
import 'src/pages/pause.dart';

class RiverWarrior extends FlameGame
    with SingleGameInstance, HasCollisionDetection {
  late final router = RouterComponent(initialRoute: 'home', routes: {
    'home': Route(HomePage.new),
    'game': Route(GamePage.new, maintainState: false),
    'pause': PauseRoute(),
    'game-over': GameOverRoute(),
  });

  Color bladeColor = BasicPalette.white.color;
  int maxMistake = 3;
  double musicVolume = 1;
  int highScore = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    FlameAudio.bgm.initialize();
    debugMode = kDebugMode;
    if (!kIsWeb) {
      FlameAudio.bgm.play('background-music.mp3', volume: musicVolume);
    }
    await images.loadAllImages();
    addAll([router]);
  }
}
