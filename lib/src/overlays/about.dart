import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/template.dart';

class AboutOverlay extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const AboutOverlay(this.context, this.game, {super.key});

  @override
  Widget build(BuildContext context) =>
      TemplateOverlay(game: game, title: 'about.title'.tr(), children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomRight,
              children: [
                Image.network(
                    'https://sungai.watch/cdn/shop/files/DSC03735_2_4216x.jpg',
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(8),
                  child: Text('@sungai.watch',
                      style: Theme.of(context).primaryTextTheme.labelSmall),
                ),
              ]),
        ),
        const SizedBox(height: 10),
        const Text("about.inspiration").tr()
      ]);
}
