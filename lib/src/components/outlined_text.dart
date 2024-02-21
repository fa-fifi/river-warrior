import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class OutlinedText extends TextComponent {
  final Color textColor;
  final Color outlineColor;

  OutlinedText(
      {super.text,
      this.textColor = Colors.white,
      this.outlineColor = Colors.black,
      super.position,
      super.scale,
      super.anchor,
      super.priority,
      super.children});

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    final fontSize = size.y / 8;
    textRenderer = TextPaint(
        style: outlinedTextStyle(
            fontSize: fontSize,
            offset: fontSize / 30 / scale.x,
            textColor: textColor,
            outlinedColor: outlineColor));
  }
}

TextStyle outlinedTextStyle(
    {required double fontSize,
    double? offset,
    Color textColor = Colors.white,
    Color outlinedColor = Colors.black}) {
  final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        textColor,
        textColor.darken(textColor == Colors.white ? 0.1 : 0.5)
      ]).createShader(const Rect.fromLTWH(0, 0, 200, 70));
  offset ??= fontSize / 30;

  return TextStyle(
      fontSize: fontSize,
      foreground: Paint()..shader = gradient,
      shadows: [
        Shadow(offset: Offset(-offset, -offset), color: outlinedColor),
        Shadow(offset: Offset(offset, -offset), color: outlinedColor),
        Shadow(offset: Offset(offset, offset), color: outlinedColor),
        Shadow(offset: Offset(-offset, offset), color: outlinedColor),
      ],
      fontFamily: 'Knewave');
}
