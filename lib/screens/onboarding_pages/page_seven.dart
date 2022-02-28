import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:provider/provider.dart';

class PageSeven extends StatefulWidget {
  const PageSeven({Key? key}) : super(key: key);

  @override
  _PageSevenState createState() => _PageSevenState();
}

class _PageSevenState extends State<PageSeven> {
  bool isLoading = false;
  final RestApi restApi = RestApi();
  final Map<String, _InputCategory> data = {
    "website": _InputCategory("Website (Optional)", jsonKey: "websiteUrl"),
    "instagram": _InputCategory("Instagram",
        asset: "assets/ig.svg", jsonKey: "instagramUrl"),
    "twitter": _InputCategory("Twitter",
        asset: "assets/twitter.svg", jsonKey: "twitterUrl"),
    "facebook": _InputCategory("Facebook",
        asset: "assets/fb.svg", jsonKey: "facebookUrl")
  };
  bool isSaving = false;
  Future<bool> updateUrls() async {
    bool ans = false;
    final state = Provider.of<AppState>(context, listen: false);

    final person = state.user!;
    setState(() {
      isSaving = true;
    });
    Map<String, String> requestBody = data.map((key, value) {
      return MapEntry(value.jsonKey, value.value);
    });
    await restApi.init();
    final response = await restApi.updateProfile(person.id, requestBody);
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
        progress: (7 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTypography(
                text:
                    "Done ${Helpers.shortenText(person.firstName ?? "")} ⛱️️,",
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
              ...data.keys.map((e) {
                String? asset = data[e]!.asset;
                var left = asset == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
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
                      onChange: (text) {
                        data[e]!.value = text;
                      },
                    ),
                    Helpers.createSpacer(y: 20)
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              }).toList(),
              Helpers.createSpacer(y: 52),
              AppButton(
                child: isSaving
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : null,
                onTapped: () async {
                  bool ans = await updateUrls();
                  if (!ans) {
                    Helpers.showSnackBar(context, "An error occured while");
                    return;
                  }
                  Navigator.pushNamed(context, "/done");
                },
                text: "Save And Continue",
                buttonType: ButtonType.secondary,
              ),
              Helpers.createSpacer(y: 25)
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ));
  }
}

class _InputCategory {
  final String label;
  String value;
  final String jsonKey;
  final String? asset;
  _InputCategory(
    this.label, {
    this.value = "",
    this.asset,
    required this.jsonKey,
  });
}
