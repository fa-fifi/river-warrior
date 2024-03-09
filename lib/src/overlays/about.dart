import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/window.dart';

class AboutScreen extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const AboutScreen(this.context, this.game, {super.key});

  @override
  Widget build(BuildContext context) =>
      Window('about', game: game, title: 'about.title'.tr(), children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomRight,
              children: [
                Image.network(
                    'https://sungai.watch/cdn/shop/files/DSC03735_2_4216x.jpg?v=1694485166',
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
