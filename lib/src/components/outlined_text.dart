import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';

class OutlinedText extends TextComponent {
  final Color? textColor;
  final Color? outlineColor;

  OutlinedText(
      {required super.text,
      this.textColor,
      this.outlineColor,
      super.position,
      super.scale,
      super.anchor,
      super.priority,
      super.children})
      : super();

  @override
  void onGameResize(Vector2 size) {
    textRenderer = titleRenderer(size);
    super.onGameResize(size);
  }

  TextPaint titleRenderer(Vector2 size) {
    final fontSize = size.y / 8;
    final offset = fontSize / 25;

    return TextPaint(
      style: TextStyle(
          fontSize: fontSize,
          shadows: [
            Shadow(
                offset: Offset(-offset, -offset),
                color: outlineColor ?? BasicPalette.black.color),
            Shadow(
                offset: Offset(offset, -offset),
                color: outlineColor ?? BasicPalette.black.color),
            Shadow(
                offset: Offset(offset, offset),
                color: outlineColor ?? BasicPalette.black.color),
            Shadow(
                offset: Offset(-offset, offset),
                color: outlineColor ?? BasicPalette.black.color),
          ],
          color: textColor ?? BasicPalette.white.color,
          fontFamily: 'Knewave'),
    );
  }
}
