import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';

class OutlinedText extends TextComponent {
  final double fontSize;
  final Color? textColor;
  final Color? outlineColor;

  OutlinedText(
      {this.fontSize = 50,
      this.textColor,
      this.outlineColor,
      required super.text,
      super.position,
      super.size,
      super.scale,
      super.anchor,
      super.priority,
      super.children})
      : super(
            textRenderer: TextPaint(
          style: TextStyle(
              fontSize: fontSize,
              shadows: [
                Shadow(
                    offset: Offset(-fontSize / 25, -fontSize / 25),
                    color: outlineColor ?? BasicPalette.black.color),
                Shadow(
                    offset: Offset(fontSize / 25, -fontSize / 25),
                    color: outlineColor ?? BasicPalette.black.color),
                Shadow(
                    offset: Offset(fontSize / 25, fontSize / 25),
                    color: outlineColor ?? BasicPalette.black.color),
                Shadow(
                    offset: Offset(-fontSize / 25, fontSize / 25),
                    color: outlineColor ?? BasicPalette.black.color),
              ],
              color: textColor ?? BasicPalette.white.color,
              fontFamily: 'Knewave'),
        ));
}
