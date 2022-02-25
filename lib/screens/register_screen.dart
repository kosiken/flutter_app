import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/register_dto.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterDTO registerDTO = RegisterDTO()..firstName = "Lion";
  @override
  Widget build(BuildContext context) {
    return AppPage(
        child: SafeArea(
            child: Column(
      children: [
        const Image(
          image: AssetImage("assets/mail.png"),
          height: 75,
          width: 100,
        ),
        getNameRow(MediaQuery.of(context).size.width),
        AppTextInput(
          label: "Celebrity Aka",
          onChange: (text) {
            registerDTO.aka = text;
          },
        )
      ],
    )));
  }

  Widget getNameRow(double width) {
    if (width < 320) {
      // Handle situations where screen may be too small for inputs
      return Column(
        children: [
          AppTextInput(
            label: "First Name",
            onChange: (text) {
              registerDTO.firstName = text;
            },
          ),
          AppTextInput(
            label: "Last Name",
            onChange: (text) {
              registerDTO.lastName = text;
            },
          )
        ],
      );
    }

    return Row(
      children: [
        AppTextInput(
          label: "First Name",
          onChange: (text) {
            registerDTO.firstName = text;
          },
        ),
        AppTextInput(
          label: "Last Name",
          onChange: (text) {
            registerDTO.lastName = text;
          },
        )
      ],
    );
  }
}
