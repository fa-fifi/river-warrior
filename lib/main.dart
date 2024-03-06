import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/overlays/about.dart';
import 'package:river_warrior/src/overlays/help.dart';
import 'package:river_warrior/src/overlays/scorecard.dart';
import 'package:river_warrior/src/overlays/settings.dart';
import 'package:river_warrior/src/utils/constants.dart';
import 'package:river_warrior/src/utils/helpers.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    if (kIsDesktop) setWindowTitle(title);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale.fromSubtags(languageCode: 'en');

  void setLocale(String code) =>
      setState(() => _locale = Locale.fromSubtags(languageCode: code));

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        locale: _locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.pink),
        home: const GameWidget<RiverWarrior>.controlled(
            gameFactory: RiverWarrior.new,
            overlayBuilderMap: {
              'about': AboutScreen.new,
              'help': HelpOverlay.new,
              'scorecard': ScorecardOverlay.new,
              'settings': SettingsScreen.new,
            }),
      );
}
