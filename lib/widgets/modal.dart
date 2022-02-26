import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final double? height;
  final double borderRadius;
  final Widget child;
  final EdgeInsets padding;
  const Modal(
      {Key? key,
      this.height,
      this.borderRadius = 15,
      required this.child,
      this.padding = const EdgeInsets.all(8.0)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
      child: child,
    );
  }
}
