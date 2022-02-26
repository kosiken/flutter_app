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
  final bool disabled;

  final String text;
  final Widget? left;
  final Widget? child;
  final OnTappedCallback onTapped;
  final OnLongPressedCallback? onLongPressed;

  const AppButton(
      {Key? key,
      this.borderColor,
      this.child,
      this.text = "",
      this.buttonBgColor,
      this.buttonColor,
      this.left,
      this.disabled = false,
      required this.onTapped,
      this.borderRadius = 27.5,
      this.onLongPressed,
      this.buttonType = ButtonType.primary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors(context);
    return GestureDetector(
      onTap: () {
        if (!disabled) {
          onTapped();
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              color: colors[1],
              border: Border.all(color: colors[2], width: 1),
            ),
            child: child ??
                Center(
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

class AppIconButton extends StatelessWidget {
  final IconData iconData;
  final OnTappedCallback onTapped;
  final OnLongPressedCallback? onLongPressed;
  final double? height;
  final double? width;
  final double? iconSize;
  const AppIconButton(
      {Key? key,
      required this.onTapped,
      this.onLongPressed,
      this.iconSize,
      this.height,
      this.width,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapped,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: height ?? 35,
          width: width ?? 35,
          decoration: BoxDecoration(
              color: chipBgColor, borderRadius: BorderRadius.circular(17.5)),
          child: Icon(
            iconData,
            color: const Color.fromRGBO(0x97, 0x97, 0x97, 1),
            size: iconSize ?? 15,
          ),
        ));
  }
}
