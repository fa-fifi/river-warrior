import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
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
  double bgmVolume = 1;
  double sfxVolume = 1;

  void restart() {
    router.popUntilNamed('start');
    FlameAudio.bgm.play('background-music.mp3', volume: bgmVolume);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    FlameAudio.bgm.initialize();
    if (!kIsWeb) FlameAudio.bgm.play('background-music.mp3', volume: bgmVolume);
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
