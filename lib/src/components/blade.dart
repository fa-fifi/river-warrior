import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/utils/constants.dart';

class Blade extends Component with HasGameReference<RiverWarrior> {
  final Vector2 origin;
  final int width;

  Blade(this.origin, {this.width = 15});

  late final _paths = <Path>[Path()..moveTo(origin.x, origin.y)];
  final _opacities = <double>[1];
  late final _lastPoint = origin;
  bool _released = false;
  double _timer = 0;
  final _vanishInterval = 0.01;

  @override
  void render(Canvas canvas) {
    assert(_paths.length == _opacities.length);

    final glowPaint = Paint()..style = PaintingStyle.stroke;
    final outlinePaint = Paint()..style = PaintingStyle.stroke;
    final linePaint = Paint()..style = PaintingStyle.stroke;

    for (var i = 0; i < _paths.length; i++) {
      final path = _paths[i];
      final opacity = _opacities[i];
      if (opacity > 0) {
        if (game.bladeColor == gold) {
          glowPaint
            ..color = game.bladeColor.brighten(0.1).withOpacity(opacity)
            ..strokeWidth = width * opacity + 4
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5)
            ..strokeJoin = StrokeJoin.bevel;
          canvas.drawPath(path, glowPaint);
        }
        outlinePaint
          ..color = game.bladeColor.darken(0.3).withOpacity(opacity)
          ..strokeWidth = width * opacity + 2
          ..strokeJoin = StrokeJoin.bevel;
        canvas.drawPath(path, outlinePaint);
        linePaint
          ..color = game.bladeColor.withOpacity(opacity)
          ..strokeWidth = width * opacity
          ..strokeJoin = StrokeJoin.bevel
          ..strokeCap = StrokeCap.round;
        canvas.drawPath(path, linePaint);
      }
    }
  }

  @override
  void update(double dt) {
    assert(_paths.length == _opacities.length);
    _timer += dt;
    while (_timer > _vanishInterval) {
      _timer -= _vanishInterval;
      for (var i = 0; i < _paths.length; i++) {
        _opacities[i] -= 0.1;
      }
      if (!_released) {
        _paths.add(Path()..moveTo(_lastPoint.x, _lastPoint.y));
        _opacities.add(1);
      }
    }
    if (_opacities.last <= 0) removeFromParent();
  }

  void addPoint(Vector2 point) {
    if (point.x.isNaN) return;
    for (final path in _paths) {
      path.lineTo(point.x, point.y);
    }
    _lastPoint.setFrom(point);
  }

  void end() => _released = true;
}
