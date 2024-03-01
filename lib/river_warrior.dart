import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
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
  late final SpriteComponent background;
  Color bladeColor = BasicPalette.white.color;
  int highScore = 0;
  int maxMistake = 3;
  double bgmVolume = 0.5;
  double sfxVolume = 0.5;

  void restart() {
    router.popUntilNamed('start');
    FlameAudio.bgm.play('background-music.mp3', volume: bgmVolume);
  }

  // ignore: avoid_setters_without_getters
  set backgroundImage(String image) =>
      background.sprite?.image = images.fromCache('backgrounds/$image.png');

  @override
  Future<void> onLoad() async {
    super.onLoad();
    FlameAudio.bgm.initialize();
    if (!kIsWeb) FlameAudio.bgm.play('background-music.mp3', volume: bgmVolume);
    await FlameAudio.audioCache.loadAll([
      'countdown-start.wav',
      'game-over.wav',
      'whip-whoosh.mp3',
      'pickup-coin.wav',
      'hit-rock.mp3',
    ]);
    await images.loadAllImages();
    addAll([
      background = SpriteComponent.fromImage(
          images.fromCache('backgrounds/river.png'),
          anchor: Anchor.center),
      router = RouterComponent(initialRoute: 'start', routes: {
        'start': Route(StartPage.new),
        'play': Route(PlayPage.new, maintainState: false),
        'pause': PauseRoute(),
        'finish': FinishRoute(),
      }),
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isMounted)
      background
        ..position = size / 2
        ..size = size.x / size.y > 1.5
            ? Vector2(size.x, size.x / 1.5)
            : Vector2(size.y * 1.5, size.y);
  }
}
