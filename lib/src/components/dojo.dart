import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

import 'blade.dart';

class Dojo extends Component with DragCallbacks {
  final trails = <int, Blade>{};
  bool isReleased = true;

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    final trail = Blade(event.localPosition);

    trails[event.pointerId] = trail;
    add(trail);
    isReleased = false;
    super.onDragStart(event);
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) {
    if (!isReleased) trails[event.pointerId]!.addPoint(event.localEndPosition);
  }

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    trails.remove(event.pointerId)!.end();
    isReleased = true;
    super.onDragEnd(event);
  }
}
