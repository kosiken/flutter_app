import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:flutter_app/constants/colors.dart';

typedef InputOnChangeCallback = void Function(String value);

const AppTextInputFocusedBgColor = Color.fromRGBO(0xE6, 0x00, 0x7E, 0.05);

class AppTextInput extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final String? warning;
  final Widget? left;
  final Widget? right;
  final bool secure;
  final String defaultValue;
  final double margin;
  final int lines;
  final bool? disabled;
  final int? maxLength;
  final InputOnChangeCallback? onChange;

  const AppTextInput({
    Key? key,
    required this.label,
    this.inputType = TextInputType.text,
    this.warning,
    this.left,
    this.defaultValue = "",
    this.right,
    this.maxLength,
    this.margin = 0,
    this.lines = 1,
    this.secure = false,
    this.onChange,
    this.disabled,
  }) : super(key: key);

  @override
  _AppTextInputState createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  FocusNode focusNode = FocusNode();
  late TextEditingController controller;
  Color bgColor = Colors.white;
  Color color = textInputColor;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(_focusChangeColor);
    setState(() {
      controller = TextEditingController(text: widget.defaultValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 1),
                  color: bgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    widget.left ?? const SizedBox(),
                    Expanded(
                        child: TextField(
                      focusNode: focusNode,
                      maxLines: (widget.inputType == TextInputType.multiline
                          ? null
                          : widget.lines),
                      maxLength: widget.maxLength,
                      enabled: !(widget.disabled ?? false),
                      controller: controller,
                      obscureText: widget.secure,
                      autofocus: false,
                      decoration: const InputDecoration.collapsed(
                        hintText: "",
                      ),
                      keyboardType: widget.inputType,
                      onChanged: widget.onChange,
                    )),
                    widget.right ?? const SizedBox(),
                  ],
                ),
              ),
              if (widget.warning != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: primaryColor),
                      AppTypography(
                        text: widget.warning!,
                        textColor: primaryColor,
                      )
                    ],
                  ),
                )
            ]),
            Positioned(
              child: AppTypography(
                text: widget.label,
                textColor: color,
                bgColor: Colors.white,
              ),
              left: 10,
              top: -8,
            ),
          ],
        ));
  }

  _focusChangeColor() {
    setState(() {
      if (focusNode.hasFocus) {
        bgColor = AppTextInputFocusedBgColor;
        color = Theme.of(context).primaryColor;
      } else {
        bgColor = Colors.white;
        color = textInputColor;
      }
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_focusChangeColor);
    focusNode.dispose();
    super.dispose();
  }
}


/**
 *   child: Stack(
        children: [
          Positioned(
            child: AppTypography(
              text: widget.label,
              textColor: color,
            ),
            left: 10,
            top: 3,
          ),
          Column(
            children: [
              Row(
                children: [
                  widget.left ?? const SizedBox(),
                  Expanded(
                      child: TextField(
                    focusNode: focusNode,
                    maxLength: widget.maxLength,
                    enabled: !(widget.disabled!),
                    controller: widget.controller,
                    obscureText: widget.secure,
                    autofocus: false,
                    decoration: const InputDecoration.collapsed(
                      hintText: "",
                    ),
                    keyboardType: widget.inputType,
                    onChanged: widget.onChange,
                  )),
                  widget.right ?? const SizedBox(),
                ],
              ),
              if (widget.warning != null)
                Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor),
                    AppTypography(
                      text: widget.warning!,
                      textColor: primaryColor,
                    )
                  ],
                )
            ],
          )
        ],
      ),
    );
 */