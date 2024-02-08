import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';

import 'src/pages/game.dart';
import 'src/pages/game_over.dart';
import 'src/pages/home.dart';
import 'src/pages/pause.dart';
import 'src/utils/constants.dart';

class RiverWarrior extends FlameGame with SingleGameInstance {
  late final RouterComponent router;
  late double maxVerticalVelocity;
  Color bladeColor = BasicPalette.white.color;

  @override
  Future<void> onLoad() async {
    FlameAudio.bgm
      ..initialize()
      ..play('background-music.mp3');
    await images.loadAllImages();
    addAll([
      router = RouterComponent(initialRoute: 'home', routes: {
        'home': Route(HomePage.new),
        'game': Route(GamePage.new),
        'pause': PauseRoute(),
        'game-over': GameOverRoute(),
      })
    ]);
    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    maxVerticalVelocity =
        sqrt(2 * (gravity.abs() + acceleration.abs()) * (size.y - objSize * 2));
    super.onGameResize(size);
  }
}
