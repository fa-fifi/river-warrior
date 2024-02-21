import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/src/widgets/window.dart';

import '../../river_warrior.dart';

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
          const Text('Background Music'),
          const Spacer(),
          Slider(
              value: widget.game.bgmVolume,
              divisions: 10,
              label: '${widget.game.bgmVolume * 100}',
              onChanged: (value) {
                setState(() => widget.game.bgmVolume = value);
                value == 0
                    ? FlameAudio.bgm.stop()
                    : !FlameAudio.bgm.isPlaying
                        ? FlameAudio.bgm
                            .play('background-music.mp3', volume: value)
                        : FlameAudio.bgm.audioPlayer.setVolume(value);
              }),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          const Text('Sound Effects'),
          const Spacer(),
          Slider(
              value: widget.game.sfxVolume,
              divisions: 10,
              label: '${widget.game.sfxVolume * 100}',
              onChanged: (value) =>
                  setState(() => widget.game.sfxVolume = value)),
        ]),
      ]);
}
