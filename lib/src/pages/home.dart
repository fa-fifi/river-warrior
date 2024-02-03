import 'package:flame/components.dart';

import '../../river_warrior.dart';
import '../components/dojo.dart';
import '../components/button.dart';

class HomePage extends Dojo with HasGameReference<RiverWarrior> {
  late final padding = game.size.y / 15;

  late final title = SpriteComponent.fromImage(
      game.images.fromCache('others/title.png'),
      anchor: Anchor.topCenter,
      priority: 1);

  late final playButton =
      Button(id: 6, onPressed: () => game.router.pushNamed('game'));

  @override
  void onLoad() async {
    addAll([title, playButton]);
    super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    const maxWidth = 500.0;
    const maxHeight = 100.0;
    final width = size.x / 2;
    final height = width / maxWidth * maxHeight;

    title
      ..position = Vector2(size.x / 2, padding)
      ..size = Vector2(width > maxWidth ? maxWidth : width,
          height > maxHeight ? maxHeight : height);

    playButton
      ..position = size / 2
      ..size = Vector2.all(100);

    super.onGameResize(size);
  }
}
