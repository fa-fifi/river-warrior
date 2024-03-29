import 'package:easy_localization/easy_localization.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/template.dart';

class SettingsOverlay extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const SettingsOverlay(this.context, this.game, {super.key});

  @override
  State<SettingsOverlay> createState() => _SettingsOverlayState();
}

class _SettingsOverlayState extends State<SettingsOverlay> {
  @override
  Widget build(BuildContext context) => TemplateOverlay(
          game: widget.game,
          title: 'settings.title'.tr(),
          children: [
            Row(children: [
              const SizedBox(width: 16),
              Text('settings.bgm'.tr()),
              const Spacer(),
              Slider(
                  value: widget.game.bgmVolume,
                  divisions: 10,
                  label: '${(widget.game.bgmVolume * 100).toInt()}',
                  onChanged: (value) {
                    setState(() => widget.game.bgmVolume = value);
                    !FlameAudio.bgm.isPlaying
                        ? FlameAudio.bgm
                            .play('background-music.mp3', volume: value)
                        : FlameAudio.bgm.audioPlayer.setVolume(value);
                  }),
            ]),
            const SizedBox(height: 10),
            Row(children: [
              const SizedBox(width: 16),
              Text('settings.sfx'.tr()),
              const Spacer(),
              Slider(
                  value: widget.game.sfxVolume,
                  divisions: 10,
                  label: '${(widget.game.sfxVolume * 100).toInt()}',
                  onChanged: (value) =>
                      setState(() => widget.game.sfxVolume = value)),
            ]),
            Row(children: [
              const SizedBox(width: 16),
              Text('settings.lng'.tr()),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                    onPressed: () => context.setLocale(Locale(
                        context.locale.languageCode == 'ja' ? 'en' : 'ja')),
                    child: const Text('language').tr()),
              )
            ]),
          ]);
}
