import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Key? scaffoldKey;
  final EdgeInsets? padding;
  const AppPage({Key? key, required this.child, this.scaffoldKey, this.padding})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
        child: child,
      ),
    );
  }
}
