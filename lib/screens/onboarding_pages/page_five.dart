import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  _BankListItem? _bankListItem;
  final GlobalKey<AppTextInputState> _inputKey =
      GlobalKey<AppTextInputState>(debugLabel: "Bank Key");
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AppTypography(
            text: "Almost Ademola ⚙️️,",
            textType: TextTypes.header,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            textAlign: TextAlign.start,
            textColor: secondaryDarker,
          ),
          Helpers.createSpacer(y: 10),
          const AppTypography(
            text: "Set up your withdrawal account",
            fontSize: 18,
            textType: TextTypes.header,
            fontWeight: FontWeight.w700,
            textColor: secondaryDarker,
          ),
          Helpers.createSpacer(y: 10),
          const AppTypography(
              text:
                  "Please set up your preferred withdrawal account and we’ll direct your funds to it"),
          Helpers.createSpacer(y: 30),
          AppTextInput(
            left: Helpers.createSpacer(x: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            label: "Please Select a Bank",
            key: _inputKey,
            defaultValue: _bankListItem?.bankName ?? "",
            disabled: true,
            renderLabel: false,
            right: PopupMenuButton<_BankListItem>(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 25,
                  color: chipTextColor,
                ),
                onSelected: (bank) {
                  final controller = _inputKey.currentState!.controller;
                  controller.text = bank.bankName;
                  setState(() {
                    _bankListItem = bank;
                  });
                },
                itemBuilder: (c) => _BankListItem.randomBanks()
                    .map((e) => PopupMenuItem<_BankListItem>(
                          value: e,
                          child: AppTypography(
                            text: e.bankName,
                          ),
                        ))
                    .toList()),
          ),
          Helpers.createSpacer(y: 30),
          AppTextInput(
            left: Helpers.createSpacer(x: 10),
            inputType: TextInputType.number,
            label: "Enter account number",
            renderLabel: false,
          ),
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

class _BankListItem {
  final int bankCode;
  final String bankName;

  _BankListItem({required this.bankCode, required this.bankName});

  static List<_BankListItem> randomBanks() => [
        "Access Bank",
        "Guaranty Trust Bank",
        "First Bank"
      ].map((e) => _BankListItem(bankCode: 100, bankName: e)).toList();
}
