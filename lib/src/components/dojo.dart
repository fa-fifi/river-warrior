import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'blade.dart';

class Dojo extends Component with DragCallbacks {
  /// We will store all current circles into this map, keyed by the `pointerId`
  /// of the event that created the circle.
  final Map<int, Blade> _trails = {};

  @override
  bool get isDragged => true;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    final trail = Blade(event.localPosition);
    _trails[event.pointerId] = trail;
    add(trail);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _trails[event.pointerId]!.addPoint(event.localEndPosition);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _trails.remove(event.pointerId)!.end();
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    _trails.remove(event.pointerId)!.cancel();
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;
}
