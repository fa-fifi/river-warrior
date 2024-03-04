import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/models/powerup.dart';

class ScorecardOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const ScorecardOverlay(this.context, this.game, {super.key});

  @override
  State<ScorecardOverlay> createState() => _ScorecardOverlayState();
}

class _ScorecardOverlayState extends State<ScorecardOverlay> {
  final powerup = Powerup.goldenStraw;

  @override
  Widget build(BuildContext context) => TapRegion(
        onTapOutside: (event) => widget.game
          ..overlays.remove('scorecard')
          ..restart(),
        child: Center(
          child: Card(
            child: Column(
              children: [
                Text(widget.game.tally.toString()),
                AddToGoogleWalletButton(
                  pass: powerup.generatePass(widget.game.score),
                  locale: Locale.fromSubtags(
                      languageCode:
                          Localizations.localeOf(context).languageCode == 'ja'
                              ? 'jp'
                              : 'en'),
                ),
              ],
            ),
          ),
        ),
      );
}
