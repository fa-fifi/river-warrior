import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/painting.dart';

class OutlinedText extends TextComponent {
  final Color? textColor;
  final Color? outlineColor;

  OutlinedText(
      {super.text,
      this.textColor,
      this.outlineColor,
      super.position,
      super.scale,
      super.anchor,
      super.priority,
      super.children});

  TextPaint titleRenderer(Vector2 size) {
    final fontSize = size.y / 8;
    final offset = fontSize / 30 / scale.x;
    final color = textColor ?? BasicPalette.white.color;
    final gradient = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[color, color.darken(textColor == null ? 0.1 : 0.5)])
        .createShader(const Rect.fromLTWH(0, 0, 200, 70));

    return TextPaint(
      style: TextStyle(
          fontSize: fontSize,
          foreground: Paint()..shader = gradient,
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
          fontFamily: 'Knewave'),
    );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    textRenderer = titleRenderer(size);
  }
}
