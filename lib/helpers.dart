import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
}
