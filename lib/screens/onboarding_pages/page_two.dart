import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/typography.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: const [
          AppTypography(
            text: "Smile Ademola 📸️,",
            textType: TextTypes.header,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            textAlign: TextAlign.start,
            textColor: secondaryDarker,
          )
        ]),
        Row(children: const [
          AppTypography(
            text: "It’s time to take a picture",
            fontSize: 18,
            textType: TextTypes.header,
            fontWeight: FontWeight.w700,
            textColor: secondaryDarker,
          )
        ]),
        Helpers.createSpacer(y: 10),
        const AppTypography(
          text:
              "Please upload or take a picture for your fans to easily recognize and book an experience",
          textColor: secondaryColor,
        ),
        Helpers.createSpacer(y: 30),
        GestureDetector(
          child: Center(
              child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  color: chipBgColor,
                ),
                height: 150,
                width: 150,
                child: const Center(
                    child: Icon(
                  Icons.person_add,
                  size: 55,
                )),
              ),
              Positioned(
                  right: 0,
                  bottom: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0x11, 0x95, 0xFF, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.white,
                    ),
                  ))
            ],
          )),
        ),
        Helpers.createSpacer(y: 52),
        AppButton(
          onTapped: () {},
          text: "Save And Continue",
          buttonType: ButtonType.secondary,
        )
      ],
    );
  }
}
