import 'dart:math';

import 'package:flame/game.dart';

import 'src/utils.dart/app_config.dart';
import 'src/overlays/game_over.dart';
import 'src/overlays/game.dart';
import 'src/overlays/home.dart';
import 'src/overlays/pause.dart';

class RiverWarrior extends FlameGame with SingleGameInstance {
  late final RouterComponent router;
  late double maxVerticalVelocity;

  @override
  void onLoad() async {
    router = RouterComponent(initialRoute: 'home', routes: {
      'home': Route(HomePage.new),
      'game-page': Route(GamePage.new),
      'pause': PauseRoute(),
      'game-over': GameOverRoute()
    });
    images.loadAllImages();

    addAll([router]);

    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size) {
    maxVerticalVelocity = sqrt(2 *
        (AppConfig.gravity.abs() + AppConfig.acceleration.abs()) *
        (size.y - AppConfig.objSize * 2));
  }
}
