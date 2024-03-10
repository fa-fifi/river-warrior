import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/models/coin.dart';
import 'package:river_warrior/src/models/plastic.dart';
import 'package:river_warrior/src/models/rock.dart';
import 'package:river_warrior/src/overlays/template.dart';

class HelpOverlay extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const HelpOverlay(this.context, this.game, {super.key});

  @override
  Widget build(BuildContext context) =>
      TemplateOverlay(game: game, title: 'help.title'.tr(), children: [
        const Text('help.intro').tr(),
        const Text('help.step1').tr(),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(plastics.map((plastic) => Image.asset(
                'assets/images/items/${plastic.name}.png',
                width: 50)))),
        const SizedBox(height: 20),
        const Text('help.step2').tr(),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(coins.map((coin) => Image.asset(
                'assets/images/items/${coin.name}.png',
                width: 50)))),
        const SizedBox(height: 20),
        const Text('help.step3').tr(),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(rocks.map((rock) => Image.asset(
                'assets/images/items/${rock.name}.png',
                width: 50)))),
        const SizedBox(height: 20),
        const Text('help.outro').tr(),
      ]);
}
