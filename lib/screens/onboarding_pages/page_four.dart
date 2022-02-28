import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/celebrity_service.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  bool isLoading = false;
  String warning = "";
  bool isSaving = false;
  RestApi restApi = RestApi();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> updateProfile() async {
    final state = Provider.of<AppState>(context, listen: false);
    setState(() {
      isSaving = true;
    });
    bool updated = false;

    final Person person = state.user!;
    Map<String, dynamic> json = state.service!.toJson();
    json["celebrityId"] = person.id;
    json["serviceId"] = state.service!.id;
    json.remove("id");

    final response = await restApi.updateProfile(person.id, {
      "serviceInformation": [json]
    });
    if (!response.isError) {
      updated = response.result!;
    }
    setState(() {
      isSaving = false;
    });
    return updated;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context, listen: false);

    final person = state.user!;

    return OnboardingScreenLayout(
        asset: "assets/notes.svg",
        isLoading: isLoading,
        progress: (4 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppTypography(
                text:
                    "Cha-Ching ${Helpers.shortenText(person.firstName ?? "")} 💵️,",
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textAlign: TextAlign.start,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                text: "Time to put a price on it",
                fontSize: 18,
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                textColor: secondaryDarker,
              ),
              Helpers.createSpacer(y: 10),
              const AppTypography(
                  text:
                      "Please set a price you’d like your fans to pay for your service"),
              Helpers.createSpacer(y: 30),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.5, horizontal: 12.5),
                  child: AppTypography(
                    text: state.service!.name,
                    textColor: Colors.white,
                  ),
                ),
              ),
              Helpers.createSpacer(y: 15),
              AppTextInput(
                label: "Enter preferred amount",
                left: const Padding(
                  padding: EdgeInsets.only(right: 10, bottom: 5, left: 3),
                  child: AppTypography(
                    text: "₦",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                inputType: TextInputType.number,
                onChange: (v) {
                  final price = double.tryParse(v);
                  if (price == null) {
                    setState(() {
                      warning = "Input a number";
                    });
                  } else {
                    setState(() {
                      warning = "";
                    });
                    CelebrityService serviceSelected = state.service!;
                    state.service = CelebrityService(
                        id: serviceSelected.id,
                        name: serviceSelected.name,
                        description: serviceSelected.description,
                        businessPrice: price,
                        fanPrice: price);
                  }
                },
                renderLabel: false,
                warning: warning,
              ),
              Helpers.createSpacer(y: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: chipBgColor,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info,
                      color: chipTextColor,
                    ),
                    Helpers.createSpacer(x: 10),
                    Expanded(
                        child: RichText(
                            text: TextSpan(
                                style: AppTypography.generateTextStyle(
                                    textColor: chipTextColor,
                                    textType: TextTypes.small),
                                children: const <TextSpan>[
                          TextSpan(text: "We recommend a minimum price of"),
                          TextSpan(
                              text: " ₦100,000",
                              style: TextStyle(color: greenColor)),
                          TextSpan(text: " and maximum price of"),
                          TextSpan(
                              text: " ₦1,000,000",
                              style: TextStyle(color: greenColor)),
                          TextSpan(text: " for video shoutout - fans")
                        ])))
                  ],
                ),
              ),
              Helpers.createSpacer(y: 52),
              AppButton(
                child: isSaving
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : null,
                disabled: isSaving,
                onTapped: () async {
                  if (state.service!.businessPrice == null) {
                    Helpers.showSnackBar(context, "Input a valid price");
                    return;
                  }
                  bool ans = await updateProfile();
                  if (!ans) {
                    Helpers.showSnackBar(context, "An error occured while");
                    return;
                  }
                  Navigator.pushNamed(context, "/onboarding_page_5");
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
