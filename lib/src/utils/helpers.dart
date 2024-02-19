import 'dart:io';
import 'dart:math';

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
