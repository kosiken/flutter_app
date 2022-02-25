import 'package:flutter/material.dart';
import 'package:flutter_app/debug.dart';

enum TextTypes { body, header, small }

class AppTypography extends StatelessWidget {
  final TextTypes textType;
  final Color? textColor;
  final Color? bgColor;
  final String text;
  final double? height;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const AppTypography(
      {Key? key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.fontWeight = FontWeight.normal,
      this.textColor,
      this.bgColor,
      this.height,
      this.textType = TextTypes.body})
      : super(key: key);

  TextStyle _generateTextStyle(BuildContext context) {
    double size = 0;
    switch (textType) {
      case TextTypes.small:
        size = 10;
        break;
      case TextTypes.body:
        size = 14;
        break;
      case TextTypes.header:
        size = 20;
        break;

      default:
        Debug.log("Undefined size '$textType' found \n ");
        size = 12;
        break;
    }

    final color = textColor ?? textColor;
    return TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        decoration: TextDecoration.none,
        color: color,
        backgroundColor: bgColor,
        height: height);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = _generateTextStyle(context);
    return Text(
      text,
      textDirection: TextDirection.ltr,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
