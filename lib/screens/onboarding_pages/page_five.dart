import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  _PageFiveState createState() => _PageFiveState();
}

class _PageFiveState extends State<PageFive> {
  _BankListItem? _bankListItem;
  RestApi restApi = RestApi();
  bool isLoading = false;
  String bankAccountNumber = "";
  bool isSaving = false;
  String warning = "";
  final GlobalKey<AppTextInputState> _inputKey =
      GlobalKey<AppTextInputState>(debugLabel: "Bank Key");

  Future<bool> updateBank(Map<String, String> json) async {
    bool ans = false;
    setState(() {
      isSaving = true;
    });
    await restApi.init();

    final response = await restApi.updateBank(json);
    if (!response.isError) {
      ans = response.result!;
    }

    setState(() {
      isSaving = false;
    });
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);

    final person = state.user!;
    return OnboardingScreenLayout(
        asset: "assets/rocket.svg",
        isLoading: isLoading,
        progress: (5 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTypography(
                text:
                    "Almost ${Helpers.shortenText(person.firstName ?? "")} ⚙️️,",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                onChange: (text) {
                  if (text.length < 10) {
                    warning = "Enter a valid account number";
                  } else {
                    warning = "";
                  }
                  bankAccountNumber = text;
                  setState(() {});
                },
                warning: warning,
              ),
              Helpers.createSpacer(y: 52),
              AppButton(
                child: isSaving
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : null,
                onTapped: () async {
                  if (bankAccountNumber.length < 10) return;
                  bool ans = await updateBank({
                    "accountNumber": bankAccountNumber,
                    "accountName": person.firstName!
                  });
                  if (!ans) {
                    Helpers.showSnackBar(context, "An error occured while");
                    return;
                  }
                  Navigator.pushNamed(context, "/onboarding_page_6");
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
