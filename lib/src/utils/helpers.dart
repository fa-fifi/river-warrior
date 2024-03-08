import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flame/input.dart';

bool get kIsDesktop =>
    Platform.isWindows || Platform.isLinux || Platform.isMacOS;

int getSliceAngle(
    {required Vector2 center,
    required double initAngle,
    required Vector2 touch}) {
  final touchPoint = touch - center;

  double angle = atan2(touchPoint.y, touchPoint.x);

  angle -= initAngle;
  angle %= 2 * pi;

  return radiansToDegrees(angle).toInt();
}

double radiansToDegrees(double angle) => angle * 180 / pi;

String generateRandomString(
        {required int length,
        String chars =
            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'}) =>
    String.fromCharCodes(Iterable.generate(length,
        (_) => chars.codeUnitAt(Random.secure().nextInt(chars.length))));

extension HexColor on Color {
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
