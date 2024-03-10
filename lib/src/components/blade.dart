import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';

class Blade extends Component with HasGameReference<RiverWarrior> {
  final Vector2 origin;
  final int width;
  final double vanishInterval;

  Blade(this.origin, {this.width = 15, this.vanishInterval = 0.01});

  late final _paths = <Path>[Path()..moveTo(origin.x, origin.y)];
  final _opacities = <double>[1];
  late final _lastPoint = origin;
  bool _released = false;
  double _timer = 0;

  @override
  void render(Canvas canvas) {
    assert(_paths.length == _opacities.length);

    for (var i = 0; i < _paths.length; i++) {
      final path = _paths[i];
      final opacity = _opacities[i];

      if (opacity > 0) {
        final outlinePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = game.bladeColor.darken(0.3).withOpacity(opacity)
          ..strokeWidth = width * opacity + 2;

        canvas.drawPath(path, outlinePaint);

        final linePaint = Paint()
          ..style = PaintingStyle.stroke
          ..color = game.bladeColor.withOpacity(opacity)
          ..strokeWidth = width * opacity
          ..strokeCap = StrokeCap.round;

        canvas.drawPath(path, linePaint);
      }
    }
  }

  @override
  void update(double dt) {
    assert(_paths.length == _opacities.length);

    _timer += dt;
    while (_timer > vanishInterval) {
      _timer -= vanishInterval;
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
