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

class OnboardingScreenLayout extends StatelessWidget {
  final String asset;
  final double progress;
  final bool canPop;
  final bool isLoading;
  final Widget child;
  const OnboardingScreenLayout(
      {Key? key,
      required this.asset,
      required this.child,
      this.canPop = true,
      required this.isLoading,
      required this.progress})
      : super(key: key);

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
                          onTapped: () {
                            if (canPop) {
                              Navigator.of(context).pop();
                            }
                          },
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
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: chipBgColor),
                    child: Image(
                      image: Svg(asset),
                      height: 24,
                      width: 24,
                    )),
                Helpers.createSpacer(y: 20),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: child))
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )));
  }
}
