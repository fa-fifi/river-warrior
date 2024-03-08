import 'package:easy_localization/easy_localization.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/window.dart';

class SettingsScreen extends StatefulWidget {
  final BuildContext context;
  final RiverWarrior game;

  const SettingsScreen(this.context, this.game, {super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) =>
      Window('settings', game: widget.game, children: [
        Row(children: [
          const SizedBox(width: 16),
          const Text('Background Music'),
          const Spacer(),
          Slider(
              value: widget.game.bgmVolume,
              divisions: 10,
              label: '${(widget.game.bgmVolume * 100).toInt()}',
              onChanged: (value) {
                setState(() => widget.game.bgmVolume = value);
                !FlameAudio.bgm.isPlaying
                    ? FlameAudio.bgm.play('background-music.mp3', volume: value)
                    : FlameAudio.bgm.audioPlayer.setVolume(value);
              }),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          const SizedBox(width: 16),
          const Text('Sound Effects'),
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
          const Text('Languages'),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
                onPressed: () => context.setLocale(
                    Locale(context.locale.languageCode == 'ja' ? 'en' : 'ja')),
                child: const Text('language').tr()),
          )
        ]),
      ]);
}
