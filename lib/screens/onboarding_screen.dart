import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/onboarding_pages/page_one.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/page.dart';
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
  List<Category> categories = [];
  @override
  void initState() {
    super.initState();

    _person = Provider.of<AppState>(context, listen: false).user!;

    loadCategories();
  }

  void loadCategories() async {
    final response = await api.getCategories(0);
    if (mounted) {
      if (response.isError) {
        Helpers.showSnackBar(context, "An error occurred while loading");
      } else {
        categories.addAll(response.result!);
      }
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
                  value: progress,
                  backgroundColor: chipBgColor,
                ),
                Helpers.createSpacer(y: 20),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Row(children: const [
                              AppTypography(
                                text: "Perfect Ademola 😎️,",
                                textType: TextTypes.header,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                textAlign: TextAlign.start,
                                textColor: secondaryDarker,
                              )
                            ]),
                            Row(children: const [
                              AppTypography(
                                text: "Getting closer to meeting your fans",
                                fontSize: 18,
                                textType: TextTypes.header,
                                fontWeight: FontWeight.w700,
                                textColor: secondaryDarker,
                              )
                            ]),
                            Helpers.createSpacer(y: 10),
                            const AppTypography(
                              text:
                                  "Please select a maximum of 5 secondary celebrity category that your fans can use to identify you",
                              textColor: secondaryColor,
                            ),
                          ],
                        )))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
