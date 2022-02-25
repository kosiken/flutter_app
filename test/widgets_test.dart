import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('It renders Button and accepts tap input',
      (WidgetTester tester) async {
    int number = 0;

    var btn = Directionality(
        textDirection: TextDirection.ltr,
        child: AppButton(
            text: "Button",
            onTapped: () {
              number = 10;
            }));
    await tester.pumpWidget(btn);
    expect(find.text("Button"), findsOneWidget);
    await tester.tap(find.text("Button"));
    await tester.pump();
    expect(number, equals(10));
  });

  testWidgets('It renders Text', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Text("text")),
    ));
    expect(find.text("text"), findsOneWidget);
  });
}
