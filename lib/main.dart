import 'package:easy_localization/easy_localization.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Route;
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
  await EasyLocalization.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
    if (kIsDesktop) setWindowTitle(title);
  }

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en'), Locale('ja')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    useOnlyLangCode: true,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
