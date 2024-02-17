import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

import 'blade.dart';

class Dojo extends Component with DragCallbacks {
  final trails = <int, Blade>{};
  bool isReleased = true;
  bool isPaused = false;

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    if (isPaused) return;
    final trail = Blade(event.localPosition);

    trails[event.pointerId] = trail;
    add(trail);
    isReleased = false;
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) {
    if (!isReleased) trails[event.pointerId]!.addPoint(event.localEndPosition);
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    trails.remove(event.pointerId)!.end();
    isReleased = true;
  }
}
