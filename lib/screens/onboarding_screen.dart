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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
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
  final Map<String, _InputCategory> data = {
    "website": _InputCategory("Website (Optional)"),
    "instagram": _InputCategory("Instagram", asset: "assets/ig.svg"),
    "twitter": _InputCategory("Twitter", asset: "assets/twitter.svg"),
    "facebook": _InputCategory("Facebook", asset: "assets/fb.svg")
  };
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
                                text: "Done Ademola ⛱️️,",
                                textType: TextTypes.header,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                textAlign: TextAlign.start,
                                textColor: secondaryDarker,
                              ),
                              Helpers.createSpacer(y: 10),
                              const AppTypography(
                                text: "Personal social accounts",
                                fontSize: 18,
                                textType: TextTypes.header,
                                fontWeight: FontWeight.w700,
                                textColor: secondaryDarker,
                              ),
                              Helpers.createSpacer(y: 10),
                              const AppTypography(
                                  text:
                                      "Please enter the url and/or identification for your social media accounts (optional)"),
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
                              ...data.keys.map((e) {
                                String? asset = data[e]!.asset;
                                var left = asset == null
                                    ? SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Image(
                                          image: Svg(asset),
                                          height: 20,
                                          width: 20,
                                        ));
                                return Column(
                                  children: [
                                    AppTypography(
                                      text: data[e]!.label,
                                      textColor: chipTextColor,
                                    ),
                                    AppTextInput(
                                      label: "",
                                      renderLabel: false,
                                      left: left,
                                    ),
                                    Helpers.createSpacer(y: 20)
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                );
                              }).toList(),
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

class _InputCategory {
  final String label;
  String? value;
  final String? asset;
  _InputCategory(
    this.label, {
    this.value,
    this.asset,
  });
}
