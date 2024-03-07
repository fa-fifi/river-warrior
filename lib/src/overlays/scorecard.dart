import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';

class ScorecardOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const ScorecardOverlay(this.context, this.game, {super.key});

  @override
  State<ScorecardOverlay> createState() => _ScorecardOverlayState();
}

class _ScorecardOverlayState extends State<ScorecardOverlay>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => TapRegion(
        onTapOutside: (_) => widget.game
          ..overlays.remove('scorecard')
          ..restart(),
        child: Center(
          child: Visibility(
            visible: widget.game.powerup != null,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/powerups/${widget.game.powerup!.label}.png',
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${widget.game.powerup!.label} #${widget.game.powerup!.index}'),
                      Text(widget.game.powerup!.requirement),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        child: AddToGoogleWalletButton(
                          onError: (e) => debugPrint(e.toString()),
                          pass: widget.game.powerup!
                              .generatePass(widget.game.score),
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
          ),
        ),
      );
}
