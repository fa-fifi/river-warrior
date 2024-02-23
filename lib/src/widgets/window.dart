import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';

class Window extends StatelessWidget {
  final String path;
  final String? title;
  final RiverWarrior game;
  final List<Widget> children;

  const Window(this.path,
      {super.key, this.title, required this.game, required this.children});

  @override
  Widget build(BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.amber,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2)),
        title: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(title ?? path[0].toUpperCase() + path.substring(1),
              style: Theme.of(context).primaryTextTheme.labelMedium),
        ),
        content: TapRegion(
            onTapOutside: (_) => game.overlays.remove(path),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children))),
      );
}
