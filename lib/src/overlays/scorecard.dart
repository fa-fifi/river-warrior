import 'package:add_to_google_wallet/widgets/add_to_google_wallet_button.dart';
import 'package:flutter/material.dart';
import 'package:river_warrior/river_warrior.dart';
import 'package:uuid/uuid.dart';

class ScorecardOverlay extends StatelessWidget {
  final BuildContext context;
  final RiverWarrior game;

  const ScorecardOverlay(this.context, this.game, {super.key});
  @override
  Widget build(BuildContext context) => TapRegion(
        onTapOutside: (event) => game
          ..overlays.remove('scorecard')
          ..restart(),
        child: Center(
          child: AddToGoogleWalletButton(
            pass: _examplePass,
            locale: Locale.fromSubtags(
                languageCode:
                    Localizations.localeOf(context).languageCode == 'ja'
                        ? 'jp'
                        : 'en'),
          ),
        ),
      );
}

final String _passId = const Uuid().v4();
const String _passClass = 'POWERUP';
const String _issuerId = '3388000000022326215';
const String _issuerEmail = 'fafifi1997@gmail.com';

final String _examplePass = """
    {
      "iss": "$_issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$_issuerId.$_passId",
            "classId": "$_issuerId.$_passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#4285f4",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Google I/O '22 [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Attendee"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Alex McJacobs"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$_passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "1234",
                "id": "points"
              }
            ]
          }
        ]
      }
    }
""";
