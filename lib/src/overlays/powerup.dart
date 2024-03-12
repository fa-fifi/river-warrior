import 'package:easy_localization/easy_localization.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:river_warrior/main.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/models/powerup.dart';
import 'package:river_warrior/src/overlays/template.dart';

class PowerupOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const PowerupOverlay(this.context, this.game, {super.key});

  @override
  State<PowerupOverlay> createState() => _PowerupOverlayState();
}

class _PowerupOverlayState extends State<PowerupOverlay> {
  @override
  Widget build(BuildContext context) => TemplateOverlay(
          game: widget.game,
          title: 'powerup.header'.tr(),
          children: [
            TextFormField(
              onChanged: (value) {
                if (value.length != 8) return;

                final index = value.indexOf('X');

                if (index.isNegative || index > 5) return;

                final isValid = value
                        .replaceAll('X', '')
                        .split('')
                        .takeWhile((value) => Powerup.values[index].name
                            .toUpperCase()
                            .contains(value))
                        .length ==
                    7;

                if (isValid) {
                  widget.game.overlays.clear();
                  HapticFeedback.heavyImpact();
                  scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    duration: const Duration(seconds: 2),
                    dismissDirection: DismissDirection.none,
                    content: Chip(
                        label: Text(Powerup.values[index].message,
                            style:
                                Theme.of(context).primaryTextTheme.bodyMedium),
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.white12)),
                  ));

                  switch (index) {
                    case 0:
                      widget.game.bladeColor = BasicPalette.red.color;
                      break;
                    case 1:
                      widget.game.bladeColor = BasicPalette.orange.color;
                      break;
                    case 2:
                      widget.game.canCutRocks = true;
                      break;
                    case 3:
                      widget.game.maxMistake = 4;
                      break;
                    case 4:
                      widget.game.backgroundImage = 'beach';
                      break;
                    case 5:
                      widget.game.backgroundImage = 'cove';
                      break;
                    default:
                  }
                }
              },
              textCapitalization: TextCapitalization.characters,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLength: 8,
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2)),
                  border: const OutlineInputBorder(),
                  hintText: 'powerup.hintText'.tr()),
            ),
          ]);
}
