import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';

import 'blade.dart';

class Dojo extends Component with DragCallbacks {
  final trails = <int, Blade>{};

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  @mustCallSuper
  void onDragStart(DragStartEvent event) {
    final trail = Blade(event.localPosition);

    trails[event.pointerId] = trail;
    add(trail);
    super.onDragStart(event);
  }

  @override
  @mustCallSuper
  void onDragUpdate(DragUpdateEvent event) =>
      trails[event.pointerId]!.addPoint(event.localEndPosition);

  @override
  @mustCallSuper
  void onDragEnd(DragEndEvent event) {
    trails.remove(event.pointerId)!.end();
    super.onDragEnd(event);
  }
}
