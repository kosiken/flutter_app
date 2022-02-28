import 'package:flutter/material.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/typography.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPage(
        child: SafeArea(
            child: Column(
      children: [
        const Image(
          image: AssetImage("assets/success.png"),
          height: 130,
          width: 130,
        ),
        Helpers.createSpacer(y: 15),
        const AppTypography(
          text: "Amaze-ing!!!",
          textType: TextTypes.header,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
        Helpers.createSpacer(y: 15),
        const AppTypography(
          text:
              "Your application is undergoing review. You will receive a notification once the review is complete.",
          textAlign: TextAlign.center,
        ),
        Helpers.createSpacer(y: 15),
        SizedBox(
          width: 200,
          child: AppButton(
            text: "Continue",
            onTapped: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/intro", (route) => !Navigator.canPop(context));
            },
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    )));
  }
}
