import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PageSeven extends StatefulWidget {
  const PageSeven({Key? key}) : super(key: key);

  @override
  _PageSevenState createState() => _PageSevenState();
}

class _PageSevenState extends State<PageSeven> {
  bool isLoading = false;
  final Map<String, _InputCategory> data = {
    "website": _InputCategory("Website (Optional)"),
    "instagram": _InputCategory("Instagram", asset: "assets/ig.svg"),
    "twitter": _InputCategory("Twitter", asset: "assets/twitter.svg"),
    "facebook": _InputCategory("Facebook", asset: "assets/fb.svg")
  };

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
        asset: "assets/rocket.svg",
        isLoading: isLoading,
        progress: (5 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppTypography(
                text: "Done Ademola ⛱️️,",
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textAlign: TextAlign.start,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                text: "Personal social accounts",
                fontSize: 18,
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                  text:
                      "Please enter the url and/or identification for your social media accounts (optional)"),
              Helpers.createSpacer(y: 30),
              ...data.keys.map((e) {
                String? asset = data[e]!.asset;
                var left = asset == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image(
                          image: Svg(asset),
                          height: 20,
                          width: 20,
                        ));
                return Column(
                  children: [
                    AppTypography(
                      text: data[e]!.label,
                      textColor: chipTextColor,
                    ),
                    AppTextInput(
                      label: "",
                      renderLabel: false,
                      left: left,
                    ),
                    Helpers.createSpacer(y: 20)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              }).toList(),
              Helpers.createSpacer(y: 52),
              AppButton(
                onTapped: () {
                  Navigator.pushNamed(context, "/success");
                },
                text: "Save And Continue",
                buttonType: ButtonType.secondary,
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ));
  }
}

class _InputCategory {
  final String label;
  String? value;
  final String? asset;
  _InputCategory(
    this.label, {
    this.value,
    this.asset,
  });
}
