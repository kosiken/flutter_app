import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/listable.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:flutter_app/constants/colors.dart';

typedef InputOnChangeCallback = void Function(String value);

class AppTextInput extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final EdgeInsets? padding;
  final String warning;
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
    this.warning = "",
    this.padding,
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
  AppTextInputState createState() => AppTextInputState();
}

class AppTextInputState extends State<AppTextInput>
    with AfterLayoutMixin<AppTextInput> {
  FocusNode focusNode = FocusNode();
  late TextEditingController controller;
  Color bgColor = Colors.white;
  GlobalKey containerKey = GlobalKey(debugLabel: "input box");
  Color color = textInputColor;
  double warningTextWidth = 150;
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              key: containerKey,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 1.5),
                color: bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                children: [
                  widget.left ?? const SizedBox(),
                  Expanded(
                      child: TextField(
                    buildCounter: (BuildContext ctx,
                            {required int currentLength,
                            required bool isFocused,
                            required int? maxLength}) =>
                        const SizedBox(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            if (widget.warning.isNotEmpty)
              Container(
                width:
                    warningTextWidth, // we need the width to be the same as the input container
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor),
                    Helpers.createSpacer(x: 5),
                    Expanded(
                        child: AppTypography(
                      text: widget.warning,
                      textColor: primaryColor,
                      textType: TextTypes.small,
                    ))
                  ],
                ),
              ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
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
    );
  }

  _focusChangeColor() {
    setState(() {
      if (focusNode.hasFocus) {
        bgColor = appTextInputFocusedBgColor;
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

  @override
  void afterFirstLayout(BuildContext context) {
    var size = containerKey.currentContext!.size;
    if (size == null) return;
    setState(() {
      warningTextWidth = size.width;
    });
  }
}
