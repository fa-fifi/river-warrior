import 'dart:io';
import 'dart:math';

import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/template.dart';
import 'package:river_warrior/src/utils/helpers.dart';

class ScorecardOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const ScorecardOverlay(this.context, this.game, {super.key});

  @override
  State<ScorecardOverlay> createState() => _ScorecardOverlayState();
}

class _ScorecardOverlayState extends State<ScorecardOverlay> {
  late final powerup = widget.game.powerup!;
  late final passcode =
      generateRandomString(length: 8, chars: powerup.name.toUpperCase())
          .replaceRange(powerup.index, powerup.index + 1, 'X');
  bool isCopied = false;

  double get maxHeight =>
      max(250, MediaQuery.of(widget.context).size.height / 2);

  @override
  Widget build(BuildContext context) =>
      TemplateOverlay(game: widget.game, title: 'Congratulations!', children: [
        SizedBox(
          height: maxHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/powerups/${powerup.index}.jpg',
                ),
              ),
              const SizedBox.square(dimension: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${powerup.label} #${powerup.index + 1}',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(powerup.requirement),
                  const SizedBox.square(dimension: 10),
                  Text('Score', style: Theme.of(context).textTheme.titleMedium),
                  Text(widget.game.score.toString()),
                  const SizedBox.square(dimension: 10),
                  Text('Rarity',
                      style: Theme.of(context).textTheme.titleMedium),
                  Text(powerup.rarity),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: maxHeight * 0.8,
                    child: !kIsWeb && Platform.isAndroid
                        ? AddToGoogleWalletButton(
                            onError: (e) => debugPrint(e.toString()),
                            pass: powerup.generatePass(
                                score: widget.game.score, passcode: passcode),
                            locale: Locale.fromSubtags(
                                languageCode: Localizations.localeOf(context)
                                            .languageCode ==
                                        'ja'
                                    ? 'jp'
                                    : 'en'),
                          )
                        : FilledButton(
                            onPressed: () async => await Clipboard.setData(
                                    ClipboardData(text: passcode))
                                .then((_) => setState(() => isCopied = true)),
                            child:
                                Text(isCopied ? 'Code Copied!' : 'Copy Code'),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]);
}
