import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/base_api.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/celebrity_service.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/screens/onboarding_pages/page_one.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  List<CelebrityService> services = [];
  bool isLoading = false;
  RestApi restApi = RestApi();
  int selected = -1;
  @override
  void initState() {
    super.initState();
    loadServices();
  }

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
    return OnboardingScreenLayout(
        asset: "assets/gift.svg",
        isLoading: isLoading,
        progress: (3 / 7),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(children: const [
              AppTypography(
                text: "Hooray Ademola 🎉️,",
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                textAlign: TextAlign.start,
                textColor: secondaryDarker,
              )
            ]),
            Row(children: const [
              AppTypography(
                text: "We are almost there!!",
                fontSize: 18,
                textType: TextTypes.header,
                fontWeight: FontWeight.w700,
                textColor: secondaryDarker,
              )
            ]),
            Helpers.createSpacer(y: 10),
            const AppTypography(
              text: "Please select the service(s) you choose to offer on Amaze",
              textColor: secondaryColor,
            ),
            Helpers.createSpacer(y: 30),
            ...services.map((e) => _ServiceListModel(
                  selected: selected,
                  service: e,
                  onChange: (v) {
                    setState(() {
                      selected = v;
                    });
                  },
                )),
            Helpers.createSpacer(y: 52),
            AppButton(
              onTapped: () {
                Navigator.pushNamed(context, "/onboarding_page_4");
              },
              text: "Save And Continue",
              buttonType: ButtonType.secondary,
            )
          ],
        )));
  }
}

class _ServiceListModel extends StatelessWidget {
  final CelebrityService service;
  final int selected;
  final void Function(int id) onChange;
  const _ServiceListModel(
      {Key? key,
      required this.selected,
      required this.service,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = selected == service.id;
    return GestureDetector(
      onTap: () {
        onChange(service.id);
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? appTextInputFocusedBgColor : chipBgColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: isSelected
                    ? primaryColor
                    : const Color.fromRGBO(0xE3, 0xE0, 0xE0, 1),
                width: 1)),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTypography(
                  text: service.name,
                  fontWeight: FontWeight.bold,
                  textType: TextTypes.header,
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: isSelected
                              ? primaryColor
                              : const Color.fromRGBO(0xE3, 0xE0, 0xE0, 1),
                          width: 2)),
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: isSelected ? primaryColor : Colors.transparent),
                  ),
                )
              ],
            ),
            Helpers.createSpacer(y: 15),
            AppTypography(text: service.description)
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
