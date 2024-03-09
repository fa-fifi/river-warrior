import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:river_warrior/src/components/outlined_text.dart';

// TODO: Add some cool translation effects.
class Countdown extends OutlinedText {
  final VoidCallback? onCompleted;

  Countdown({this.onCompleted})
      : super(
            anchor: Anchor.center,
            textColor: BasicPalette.darkGreen.color.brighten(0.3),
            outlineColor: BasicPalette.white.color);

  final countdown = Timer(2);

  @override
  void update(double dt) {
    super.update(dt);
    countdown.update(dt);
    text = countdown.current.toInt() > 0 ? 'go'.tr() : 'ready'.tr();
    if (countdown.finished) removeFromParent();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position = size / 2;
  }

  @override
  void onRemove() {
    super.onRemove();
    onCompleted?.call();
  }
}
