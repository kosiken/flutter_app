import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';

enum ButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? buttonBgColor;
  final Color? borderColor;
  final ButtonType buttonType;
  const AppButton(
      {Key? key,
      this.borderColor,
      this.buttonBgColor,
      this.buttonColor,
      this.buttonType = ButtonType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  List<Color> getColors(BuildContext context) {
    if (borderColor != null && buttonBgColor != null && buttonColor != null) {
      return <Color>[buttonColor!, buttonBgColor!, borderColor!];
    } else if (buttonType == ButtonType.secondary) {
      return <Color>[Colors.white, secondaryColor, secondaryColor];
    }

    return <Color>[Colors.white, primaryColor, primaryColor];
  }
}
