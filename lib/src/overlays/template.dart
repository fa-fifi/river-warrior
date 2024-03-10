import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';

class TemplateOverlay extends StatelessWidget {
  final String title;
  final RiverWarrior game;
  final List<Widget> children;

  const TemplateOverlay(
      {super.key,
      required this.title,
      required this.game,
      required this.children});

  @override
  Widget build(BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2)),
        title: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(title,
              style: Theme.of(context).primaryTextTheme.labelMedium),
        ),
        content: TapRegion(
            onTapOutside: (_) => game.overlays.clear(),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children))),
      );
}
