import 'package:flutter/material.dart';
import 'package:flutter_app/api/base_api.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/celebrity_service.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/onboarding_pages/page_one.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final api = RestApi();

  Person? _person;
  double progress = .25;
  final GlobalKey<AppTextInputState> _inputKey =
      GlobalKey<AppTextInputState>(debugLabel: "Bank Key");
  bool isLoading = false;
  List<Category> categories = [];
  List<CelebrityService> services = [];

  RestApi restApi = RestApi();
  int selected = -1;
  @override
  void initState() {
    super.initState();
    // loadServices();
  }

  // void loadCategories() async {
  //   final response = await api.getCategories(0);
  //   if (mounted) {
  //     if (response.isError) {
  //       Helpers.showSnackBar(context, "An error occurred while loading");
  //     } else {
  //       categories.addAll(response.result!);
  //     }
  //     setState(() {});
  //   }
  // }

  void loadServices() async {
    await restApi.init();
    final ApiResponse<List<CelebrityService>?> response =
        await restApi.getServices();
    Debug.log(response.result);
    if (response.result != null) {
      services.clear();
      services.addAll(response.result!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
        padding: EdgeInsets.zero,
        child: SafeArea(
            left: false,
            right: false,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      AppIconButton(
                          onTapped: () {},
                          iconData: Icons.chevron_left,
                          iconSize: 20)
                    ],
                  ),
                ),
                Helpers.createSpacer(y: 20),
                LinearProgressIndicator(
                  value: isLoading ? null : progress,
                  backgroundColor: chipBgColor,
                ),
                Helpers.createSpacer(y: 20),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
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
                              AppTextInput(
                                  label: "",
                                  renderLabel: false,
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
                              Helpers.createSpacer(y: 52),
                              AppButton(
                                onTapped: () {},
                                text: "Save And Continue",
                                buttonType: ButtonType.secondary,
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
