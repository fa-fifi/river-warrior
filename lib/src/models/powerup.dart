import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/src/utils/constants.dart';
import 'package:river_warrior/src/utils/helpers.dart';

enum Powerup {
  goldenStraw(Color(0xFF575100)),
  potOfGold(Color(0xFF004D33)),
  masterShredder(Color(0xFF4D2200)),
  kingMidas(Color(0xFFBA9B03)),
  riverWarrior(Color(0xFF004466)),
  crowAndPitcher(Color(0xFF000000)),
  neptuneTrident(Color(0xFF00807D));

  final Color color;

  const Powerup(this.color);

  String get label => 'powerup.$name.label'.tr();
  String get requirement => 'powerup.$name.requirement'.tr();
  String get rarity => 'powerup.$name.rarity'.tr();
  String get description => 'powerup.$name.description'.tr();

  String generatePass(int score) {
    const passClass = String.fromEnvironment('PASS_CLASS');
    const issuerId = String.fromEnvironment('ISSUER_ID');
    const issuerEmail = String.fromEnvironment('ISSUER_EMAIL');

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
                "uri": "https://raw.github.com/fa-fifi/river-warrior/main/assets/images/others/icon.png"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "${'code'.tr()}",
                "value": "$title"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "${'code'.tr()}",
                "value": "${'powerup.header'.tr()}"
              }
            },
            "header": {
              "defaultValue": {
                "language": "${'code'.tr()}",
                "value": "$label #${index + 1}"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "https://fa-fifi.is-a.dev/river-warrior",
              "alternateText": "#${generateRandomString(length: 8, chars: name.toUpperCase()).replaceRange(index, index + 1, 'X')}"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://raw.github.com/fa-fifi/river-warrior/main/assets/images/powerups/$index.png"
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
