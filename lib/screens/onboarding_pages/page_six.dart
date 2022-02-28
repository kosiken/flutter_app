import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PageSix extends StatefulWidget {
  const PageSix({Key? key}) : super(key: key);

  @override
  _PageSixState createState() => _PageSixState();
}

class _PageSixState extends State<PageSix> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);

    final person = state.user!;
    return OnboardingScreenLayout(
        asset: "assets/document.svg",
        isLoading: isLoading,
        progress: (6 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTypography(
                text:
                    "Finally ${Helpers.shortenText(person.firstName ?? "")} 🤙️️,",
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textAlign: TextAlign.start,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                text: "Additional information required",
                fontSize: 18,
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                  text:
                      "Please upload necessary additional information to avoid duplicacy of your identity"),
              Helpers.createSpacer(y: 30),
              Row(
                children: [
                  const AppTypography(
                      textColor: chipTextColor,
                      text: "Identification Document"),
                  Helpers.createSpacer(x: 10),
                  const Icon(
                    Icons.info,
                    color: chipTextColor,
                    size: 16,
                  )
                ],
              ),
              Helpers.createSpacer(y: 5),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "I couldn't find any endpoint to upload document",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      fontSize: 16.0);
                },
                child: AppTextInput(
                    label: "",
                    renderLabel: false,
                    disabled: true,
                    right: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.5, horizontal: 15),
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: const AppTypography(
                        text: "Upload",
                        textColor: Colors.white,
                      ),
                    )),
              ),
              Helpers.createSpacer(y: 52),
              AppButton(
                onTapped: () {
                  Navigator.pushNamed(context, "/onboarding_page_7");
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
