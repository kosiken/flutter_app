import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/widgets/typography.dart';

enum ButtonType { primary, secondary }
typedef OnTappedCallback = void Function();
typedef OnLongPressedCallback = void Function();

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? buttonBgColor;
  final Color? borderColor;
  final ButtonType buttonType;
  final double borderRadius;
  final String text;
  final Widget? left;
  final OnTappedCallback onTapped;
  final OnLongPressedCallback? onLongPressed;

  const AppButton(this.text,
      {Key? key,
      this.borderColor,
      this.buttonBgColor,
      this.buttonColor,
      this.left,
      required this.onTapped,
      this.borderRadius = 25,
      this.onLongPressed,
      this.buttonType = ButtonType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    return GestureDetector(
      onTap: onTapped,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: colors[1],
              border: Border.all(color: colors[2], width: 1),
            ),
            child: Center(
              child: AppTypography(text: text, textColor: colors[0]),
            ),
          ),
          Positioned(
            child: left ?? const SizedBox(),
            left: 0,
            top: 0,
          )
        ],
      ),
    );
  }

  List<Color> _getColors(BuildContext context) {
    if (borderColor != null && buttonBgColor != null && buttonColor != null) {
      return <Color>[buttonColor!, buttonBgColor!, borderColor!];
    } else if (buttonType == ButtonType.secondary) {
      return <Color>[Colors.white, secondaryColor, secondaryColor];
    }

    return <Color>[Colors.white, primaryColor, primaryColor];
  }
}
