import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:river_warrior/src/pages/finish.dart';
import 'package:river_warrior/src/pages/pause.dart';
import 'package:river_warrior/src/pages/play.dart';
import 'package:river_warrior/src/pages/start.dart';

class RiverWarrior extends FlameGame
    with SingleGameInstance, HasCollisionDetection {
  late final RouterComponent router;
  Color bladeColor = BasicPalette.white.color;
  int highScore = 0;
  int maxMistake = 3;
  double bgmVolume = 0.5;
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
    await FlameAudio.audioCache.loadAll(['countdown-start.wav']);
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
