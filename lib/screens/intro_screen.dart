import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/typography.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/donjazzy.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(
              horizontal: ((size.width >= 414) ? 20 : 18), vertical: 30),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0,
                0.1,
                0.8
              ],
                  colors: [
                Color.fromRGBO(0x14, 0x04, 0x32, 0),
                Color.fromRGBO(0x14, 0x04, 0x32, 0.3),
                Color.fromRGBO(0x14, 0x04, 0x32, 1)
              ])),
          child: Column(
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12.5)),
                  border: Border.all(color: greenColor, width: 0.5),
                ),
                child: const Icon(
                  Icons.volume_up,
                  size: 10,
                  color: greenColor,
                ),
              ),
              Helpers.createSpacer(y: 10),
              RichText(
                text: TextSpan(
                  style: AppTypography.generateTextStyle(
                      textType: TextTypes.header, fontWeight: FontWeight.w600),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Amaze', style: TextStyle(color: primaryColor)),
                    TextSpan(
                        text: '-ing', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Helpers.createSpacer(y: 20),
              const AppTypography(
                text:
                    "Amaze   We help bridge the gap between celebrities and their fans.",
                textColor: Colors.white,
              ),
              Helpers.createSpacer(y: 20),
              AppButton(
                "Login",
                onTapped: () {
                  Navigator.of(context).pushNamed("/login");
                },
                borderColor: Colors.white,
                buttonColor: Colors.white,
                buttonBgColor: Colors.transparent,
                borderRadius: 10,
              ),
              Helpers.createSpacer(y: 20),
              AppButton(
                "Create an Account",
                onTapped: () {
                  Navigator.of(context).pushNamed("/signup");
                },
                borderColor: primaryColor,
                buttonColor: primaryColor,
                buttonBgColor: Colors.transparent,
                borderRadius: 10,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
