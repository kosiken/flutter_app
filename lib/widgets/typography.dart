import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';

enum TextTypes { body, header, small, list_tile_text }

class AppTypography extends StatelessWidget {
  final TextTypes textType;
  final Color? textColor;
  final Color? bgColor;
  final String text;
  final double? height;
  final FontWeight fontWeight;
  final double? fontSize;
  final TextAlign textAlign;

  const AppTypography(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.normal,
      this.textColor,
      this.bgColor,
      this.height,
      this.fontSize,
      this.textType = TextTypes.body})
      : super(key: key);

  static TextStyle generateTextStyle(
      {TextTypes textType = TextTypes.body,
      Color? textColor,
      FontWeight? fontWeight,
      Color? bgColor,
      double? height,
      double? fontSize}) {
    double size = 0;
    switch (textType) {
      case TextTypes.small:
        size = 12;
        break;
      case TextTypes.body:
        size = 14;
        break;
      case TextTypes.list_tile_text:
        size = 16;
        break;

      case TextTypes.header:
        size = 20;
        break;

      default:
        Debug.log("Undefined size '$textType' found \n ");
        size = 12;
        break;
    }

    final color = textColor ?? appTextColor;
    return TextStyle(
        fontSize: fontSize ?? size,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        color: color,
        backgroundColor: bgColor,
        height: height);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = generateTextStyle(
        textType: textType,
        textColor: textColor,
        fontWeight: fontWeight,
        bgColor: bgColor,
        fontSize: fontSize,
        height: height);
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
