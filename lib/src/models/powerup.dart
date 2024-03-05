import 'package:flutter/material.dart';
import 'package:river_warrior/src/utils/constants.dart';
import 'package:river_warrior/src/utils/helpers.dart';

enum Powerup {
  goldenStraw('Golden Straw',
      requirement: 'Cut 100 plastic straws in a single game.',
      rarity: 'Uncommon',
      description: 'Unlock fire blade.',
      color: Color(0xFF575100)),
  potOfGold('Pot of Gold',
      requirement: 'Collect 100 gold coins in a single game.',
      rarity: 'Uncommon',
      description: 'Unlock golden blade.',
      color: Color(0xFF004D33)),
  masterShredder('Master Shredder',
      requirement: 'Cut 500 plastics in a single game.',
      rarity: 'Rare',
      description: 'Able to collect rocks.',
      color: Color(0xFF4D2200)),
  kingMidas('King Midas',
      requirement: 'Collect 500 coins in a single game.',
      rarity: 'Rare',
      description: 'Spawn gold coins only.',
      color: Color(0xFFBA9B03)),
  riverWarrior('River Warrior',
      requirement: 'Reach 2000 points.',
      rarity: 'Epic',
      description: 'Unlock beach background.',
      color: Color(0xFF004466)),
  crowAndPitcher('The Crow and The Pitcher',
      requirement: 'Collect 500 rocks in a single game.',
      rarity: 'Epic',
      description: 'One extra live.',
      color: Color(0xFF000000)),
  neptuneTrident('Trident of Neptune',
      requirement: 'Reach 5000 points.',
      rarity: 'Legendary',
      description: 'Unlock cove background.',
      color: Color(0xFF00807D));

  final String label;
  final String requirement;
  final String rarity;
  final String description;
  final Color color;

  const Powerup(this.label,
      {required this.requirement,
      required this.rarity,
      required this.description,
      required this.color});

  String generatePass(int score) {
    const passClass = const String.fromEnvironment('PASS_CLASS');
    const issuerId = const String.fromEnvironment('ISSUER_ID');
    const issuerEmail = const String.fromEnvironment('ISSUER_EMAIL');

    return '''
    {
      "iss": "$issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$issuerId.${generateRandomString(length: 10)}",
            "classId": "$issuerId.$passClass",
            "hexBackgroundColor": "${color.toHex()}",
            "logo": {
              "sourceUri": {
                "uri": "https://raw.github.com/fa-fifi/river-warrior/main/assets/icon.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "$title"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Powerup"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "$label #${index + 1}"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "https://fa-fifi.is-a.dev/river-warrior",
              "alternateText": "#${generateRandomString(length: 8, chars: name.toUpperCase())}"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://raw.github.com/fa-fifi/river-warrior/main/assets/images/powerups/%23%23$index.png"
              }
            },
            "textModulesData": [
              {
                "id": "rarity",
                "header": "Rarity",
                "body": "$rarity"
              },
              {
                "id": "score",
                "header": "Score",
                "body": "$score"
              }
            ]
          }
        ]
      }
    }
''';
  }
}
