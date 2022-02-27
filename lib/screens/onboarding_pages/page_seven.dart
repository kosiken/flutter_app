import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';

class PageSeven extends StatefulWidget {
  const PageSeven({Key? key}) : super(key: key);

  @override
  _PageSevenState createState() => _PageSevenState();
}

class _PageSevenState extends State<PageSeven> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AppTypography(
            text: "Finally Ademola 🤙️️,",
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
                  textColor: chipTextColor, text: "Identification Document"),
              Helpers.createSpacer(x: 10),
              const Icon(
                Icons.info,
                color: chipTextColor,
                size: 16,
              )
            ],
          ),
          Helpers.createSpacer(y: 5),
          AppTextInput(
              label: "",
              renderLabel: false,
              right: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.5, horizontal: 15),
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(5)),
                child: const AppTypography(
                  text: "Upload",
                  textColor: Colors.white,
                ),
              )),
          Helpers.createSpacer(y: 52),
          AppButton(
            onTapped: () {},
            text: "Save And Continue",
            buttonType: ButtonType.secondary,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
