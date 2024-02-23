import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/models/coin.dart';
import 'package:river_warrior/src/models/plastic.dart';
import 'package:river_warrior/src/models/rock.dart';
import 'package:river_warrior/src/widgets/window.dart';

class HelpOverlay extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const HelpOverlay(this.context, this.game, {super.key});

  @override
  Widget build(BuildContext context) =>
      Window('help', game: game, title: 'How To Play', children: [
        const Text(
            'Welcome aboard, my fellow brave warrior!\nBe the savior our planet needs with these simple steps.\n'),
        const Text('Slashy Slash',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text(
            'Swipe through single-use plastics to cut them before they reach the body of water.\n'),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(plastics.map((plastic) =>
                Image.asset('assets/images/${plastic.image}.png', width: 50)))),
        const SizedBox(height: 20),
        const Text('Bling Bling',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text(
            'Collect coins to boost your score. Each coin has different number of points.\n'),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(coins.map((coin) =>
                Image.asset('assets/images/${coin.image}.png', width: 50)))),
        const SizedBox(height: 20),
        const Text('Rocky Docky',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text(
            'Watch out for rocks! Slashing them will break your blade and end the game.\n'),
        Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.from(rocks.map((rock) =>
                Image.asset('assets/images/${rock.image}.png', width: 50)))),
        const SizedBox(height: 20),
        const Text(
            "Become the ultimate 'River Warrior' and defend the waters from plastic invaders.\nReady to make a difference? Dive in now!"),
      ]);
}
