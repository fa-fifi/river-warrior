import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:river_warrior/src/widgets/window.dart';

class AboutScreen extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const AboutScreen(this.context, this.game, {super.key});

  @override
  Widget build(BuildContext context) =>
      Window('about', game: game, title: 'About This Game', children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.bottomRight,
              children: [
                Image.network(
                    'https://sungai.watch/cdn/shop/files/DSC03735_2_4216x.jpg?v=1694485166',
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover),
                Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(8),
                  child: Text('@sungai.watch',
                      style: Theme.of(context).primaryTextTheme.labelSmall),
                ),
              ]),
        ),
        const SizedBox(height: 10),
        const Text(
            "As you embark on this journey to defend our virtual river, it's important to understand the real-world inspiration behind this game. 'River Warrior' draws its spirit from the incredible efforts of Sungai Watch, a team of dedicated river warriors committed to stemming the tide of plastic pollution.\n\n"
            "Every day, the members of Sungai Watch brave the elements, working tirelessly to find innovative solutions to prevent plastic waste from reaching our oceans. Their passion and dedication serve as the driving force behind 'River Warrior,' reminding us of the urgent need to protect our rivers and oceans.\n\n"
            "Through this game, we invite you to step into the shoes of these real-life heroes, wielding your virtual sword to slash through the waves of plastic pollution threatening our waterways. With each swipe, you're not just scoring points – you're making a statement. You're standing up for our environment, advocating for cleaner rivers, and inspiring change.\n\n"
            "So, as you embark on your 'River Warrior' journey, remember the courage and determination of Sungai Watch. Let their dedication fuel your resolve to make a difference, both in the game and in the world around you. Together, we can turn the tide against plastic pollution and protect our precious waterways for generations to come.")
      ]);
}
