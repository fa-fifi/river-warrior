import 'dart:math';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/template.dart';

class ScorecardOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const ScorecardOverlay(this.context, this.game, {super.key});

  @override
  State<ScorecardOverlay> createState() => _ScorecardOverlayState();
}

class _ScorecardOverlayState extends State<ScorecardOverlay> {
  late final powerup = widget.game.powerup!;

  double get maxHeight =>
      max(250, MediaQuery.of(widget.context).size.height / 2);

  @override
  Widget build(BuildContext context) => TemplateOverlay('scorecard',
          game: widget.game,
          title: 'Congratulations!',
          children: [
            SizedBox(
              height: maxHeight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/powerups/${powerup.index}.png',
                    ),
                  ),
                  const SizedBox.square(dimension: 16),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${powerup.label} #${powerup.index}',
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(powerup.requirement),
                      const SizedBox.square(dimension: 10),
                      Text('Score',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(widget.game.score.toString()),
                      const SizedBox.square(dimension: 10),
                      Text('Rarity',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(powerup.rarity),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: maxHeight / 10,
                        child: AddToGoogleWalletButton(
                          onError: (e) => debugPrint(e.toString()),
                          pass: powerup.generatePass(widget.game.score),
                          locale: Locale.fromSubtags(
                              languageCode: Localizations.localeOf(context)
                                          .languageCode ==
                                      'ja'
                                  ? 'jp'
                                  : 'en'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]);
}
