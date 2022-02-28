import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
        asset: "assets/notes.svg",
        isLoading: isLoading,
        progress: (4 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AppTypography(
                text: "Cha-Ching Ademola 💵️,",
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textAlign: TextAlign.start,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                text: "Time to put a price on it",
                fontSize: 18,
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                  text:
                      "Please set a price you’d like your fans to pay for your service"),
              Helpers.createSpacer(y: 30),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 7.5, horizontal: 12.5),
                  child: AppTypography(
                    text: "Video ShoutOut - Fans",
                    textColor: Colors.white,
                  ),
                ),
              ),
              Helpers.createSpacer(y: 15),
              const AppTextInput(
                label: "Enter preferred amount",
                left: Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 5, left: 3),
                  child: AppTypography(
                    text: "₦",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                inputType: TextInputType.number,
                renderLabel: false,
              ),
              Helpers.createSpacer(y: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: chipBgColor,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      color: chipTextColor,
                    ),
                    Helpers.createSpacer(x: 10),
                    Expanded(
                        child: RichText(
                            text: TextSpan(
                                style: AppTypography.generateTextStyle(
                                    textColor: chipTextColor,
                                    textType: TextTypes.small),
                                children: const <TextSpan>[
                          TextSpan(text: "We recommend a minimum price of"),
                          TextSpan(
                              text: " ₦100,000",
                              style: TextStyle(color: greenColor)),
                          TextSpan(text: " and maximum price of"),
                          TextSpan(
                              text: " ₦1,000,000",
                              style: TextStyle(color: greenColor)),
                          TextSpan(text: " for video shoutout - fans")
                        ])))
                  ],
                ),
              ),
              Helpers.createSpacer(y: 52),
              AppButton(
                onTapped: () {
                  Navigator.pushNamed(context, "/onboarding_page_5");
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
