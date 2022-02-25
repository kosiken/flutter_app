import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/text.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/register_dto.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:validators/validators.dart';

import '../debug.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // RegisterDTO registerDTO = RegisterDTO()..firstName = "Lion";

  String countryCode = "+234";
  String firstName = "";
  String lastName = "";
  String celebrityAKA = "";
  String phoneNumber = "";
  String countryOfResidence = "";
  String primaryCelebrityCategory = "";
  String email = "";
  String city = "";
  String password = "";

  final RegExp capitalLetters = RegExp(r"[A-Z]");
  final RegExp smallLetters = RegExp(r"[a-z]");
  final RegExp specialCharacters = RegExp(r"[@$%^*#!\(\)]");
  Map<String, String> validationErrors = [
    "firstName",
    "lastName",
    "celebrityAKA",
    "phoneNumber",
    "countryOfResidence",
    "primaryCelebrityCategory",
    "password",
    "email",
    "city"
  ].map((e) => {e: ""}).reduce((value, element) {
    value.addAll(element);
    return value;
  });

  void submit() async {
    Debug.log(specialCharacters.hasMatch("lion\$"));
  }

  @override
  void initState() {
    super.initState();
    Debug.log(validationErrors);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppPage(
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: [
        Helpers.createSpacer(y: 15),
        const Image(
          image: AssetImage("assets/mail.png"),
          height: 75,
          width: 100,
        ),
        Helpers.createSpacer(y: 20),
        const AppTypography(
          text: "Create an Account",
          textType: TextTypes.header,
          fontWeight: FontWeight.bold,
        ),
        Helpers.createSpacer(y: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: AppTypography(
            text:
                "And access the richest collection of celebrities and amaze-ing people",
            textAlign: TextAlign.center,
          ),
        ),
        Helpers.createSpacer(y: 25),
        getNameRow(size.width),
        Helpers.createSpacer(y: 25),
        AppTextInput(
          label: "Celebrity Aka",
          onChange: (text) {
            celebrityAKA = text;
            if (text.isEmpty) {
              validationErrors["celebrityAKA"] = "Please Enter AKA";
            } else {
              validationErrors["celebrityAKA"] = "";
            }
            setState(() {});
          },
          warning: validationErrors["celebrityAKA"]!,
        ),
        Helpers.createSpacer(y: 25),
        AppTextInput(
          label: "Email Address",
          onChange: (text) {
            email = text;
            if (text.isEmpty || !isEmail(text)) {
              validationErrors["email"] = "Enter a valid email";
            } else {
              validationErrors["email"] = "";
            }
            setState(() {});
          },
          warning: validationErrors["email"]!,
        ),
        Helpers.createSpacer(y: 25),
        Row(
          children: [
            AppButton(
              borderRadius: 5,
              child: Row(children: [
                Helpers.createSpacer(x: 5),
                AppTypography(text: countryCode),
                const Icon(Icons.keyboard_arrow_down, color: textInputColor)
              ]),
              onTapped: () {},
              borderColor: textInputColor,
              buttonBgColor: Colors.transparent,
              buttonColor: appTextColor,
            ),
            Helpers.createSpacer(x: 20),
            Expanded(
                child: AppTextInput(
              maxLength: 11,
              label: "Phone number",
              onChange: (text) {
                phoneNumber = text;
                if (text.length < 10) {
                  validationErrors["phoneNumber"] = "Input valid phone number";
                } else {
                  validationErrors["phoneNumber"] = "";
                }
                setState(() {});
              },
            ))
          ],
        ),
        Helpers.createSpacer(y: 25),
        AppTextInput(
          label: "Country Of Residence",
          onChange: (text) {
            countryOfResidence = text;
            if (text.isEmpty || !isEmail(text)) {
              validationErrors["countryOfResidence"] = "Enter a Country";
            } else {
              validationErrors["countryOfResidence"] = "";
            }
            setState(() {});
          },
          warning: validationErrors["countryOfResidence"]!,
        ),
        Helpers.createSpacer(y: 25),
        AppTextInput(
          label: "City",
          onChange: (text) {
            city = text;
            if (text.isEmpty || !isEmail(text)) {
              validationErrors["city"] = "Enter a City";
            } else {
              validationErrors["city"] = "";
            }
            setState(() {});
          },
          warning: validationErrors["city"]!,
        ),
        Helpers.createSpacer(y: 25),
        GestureDetector(
          child: AppTextInput(
              label: "Primary Celebrity Category",
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              disabled: true,
              warning: validationErrors["primaryCelebrityCategory"]!,
              right: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: const BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              )),
        ),
        Helpers.createSpacer(y: 25),
        AppTextInput(
          label: "Password",
          secure: true,
          onChange: (text) {
            password = text;
            setState(() {});
          },
        ),
        Helpers.createSpacer(y: 25),
        Flex(
          direction: Axis.horizontal,
          children: [
            if (capitalLetters.hasMatch(password))
              const _PasswordIndicators(text: "Capital Letters"),
            if (smallLetters.hasMatch(password))
              const _PasswordIndicators(text: "Lowercase Letter"),
            if (specialCharacters.hasMatch(password))
              const _PasswordIndicators(text: "Special Characters")
          ],
        ),
        Helpers.createSpacer(y: 25),
        AppButton(
            text: continueText,
            onTapped: submit,
            buttonType: ButtonType.secondary,
            left: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(27.5)),
                    color: Colors.white,
                    border: Border.all(color: secondaryColor, width: 1)),
                child: const Center(
                  child: Icon(
                    Icons.mail,
                    color: secondaryColor,
                  ),
                ))),
        Helpers.createSpacer(y: 25),
      ],
    ))));
  }

  Widget getNameRow(double width) {
    if (width < 320) {
      // Handle situations where screen may be too small for inputs
      return Column(
        children: [
          AppTextInput(
            label: "First Name",
            onChange: (text) {
              firstName = text;
              if (text.isEmpty || text.length < 2) {
                validationErrors["firstName"] = "Please enter first name";
              } else {
                validationErrors["firstName"] = "";
              }
              setState(() {});
            },
            warning: validationErrors["firstName"]!,
          ),
          AppTextInput(
            label: "Last Name",
            onChange: (text) {
              lastName = text;
              if (text.isEmpty || text.length < 2) {
                validationErrors["lastName"] = "Please enter last name";
              } else {
                validationErrors["lastName"] = "";
              }
              setState(() {});
            },
            warning: validationErrors["lastName"]!,
          ),
        ],
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: AppTextInput(
              label: "First Name",
              onChange: (text) {
                firstName = text;
                if (text.isEmpty || text.length < 2) {
                  validationErrors["firstName"] = "Please enter first name";
                } else {
                  validationErrors["firstName"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["firstName"]!,
            ),
          ),
          SizedBox(
            width: 180,
            child: AppTextInput(
              label: "Last Name",
              onChange: (text) {
                lastName = text;
                if (text.isEmpty || text.length < 2) {
                  validationErrors["lastName"] = "Please enter last name";
                } else {
                  validationErrors["lastName"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["lastName"]!,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class _PasswordIndicators extends StatelessWidget {
  final String text;

  const _PasswordIndicators({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(41, 155, 1, 0.05),
      child: Row(children: [
        const Icon(
          Icons.check,
          color: greenColor,
        ),
        Helpers.createSpacer(x: 5),
        AppTypography(
          text: text,
          textType: TextTypes.small,
        )
      ]),
    );
  }
}
