import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/widgets/typography.dart';

class Helpers {
  static SizedBox createSpacer({double x = 0, double y = 0}) {
    return SizedBox(width: x, height: y);
  }

  static Future<String> loadAsset(String assetName) async {
    return await rootBundle.loadString(assetName);
  }

  static String shortenText(String text, {int length = 15}) {
    if (text.length > length) {
      return text.substring(0, length - 3) + "...";
    }
    return text;
  }

  static void showSnackBar(BuildContext context, String text) {
    var snackBar = SnackBar(
      content: AppTypography(
        text: text,
        textType: TextTypes.list_tile_text,
        textColor: primaryColor,
        textAlign: TextAlign.center,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
