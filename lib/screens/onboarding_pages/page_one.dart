import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/screens/onboarding_pages/onboarding_screen_layout.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<Category> categories = [];
  List<int> selected = [];
  RestApi restApi = RestApi();
  Person? _person;
  bool isLoading = true;
  bool isSaving = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadCategories();
  }

  void loadCategories() async {
    await restApi.init();
    _person = Provider.of<AppState>(context, listen: false).user!;
    Debug.log(jsonEncode(_person!.toJson()));
    setState(() {});
    final response = await restApi.getCategories(0);

    isLoading = false;
    if (mounted) {
      if (response.isError) {
        Helpers.showSnackBar(context, "An error occurred while loading");
      } else {
        categories.addAll(response.result!);
      }
    }
    setState(() {});
  }

  Future<bool> updateCategories() async {
    bool ans = false;

    if (selected.isNotEmpty) {
      setState(() {
        isSaving = true;
      });
      await restApi.init();

      final response = await restApi
          .updateProfile(_person!.id, {"secondaryCelebrityCategory": selected});
      if (!response.isError) {
        ans = response.result!;
      }
    }
    setState(() {
      isSaving = false;
    });
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenLayout(
        canPop: false,
        asset: "assets/badge.svg",
        isLoading: isLoading,
        progress: (1 / 7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                AppTypography(
                  text:
                      "Perfect ${Helpers.shortenText(_person?.firstName ?? "")} 😎️,",
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
                text:
                    "Please select the service(s) you choose to offer on Amaze",
                textColor: secondaryColor,
              ),
              Helpers.createSpacer(y: 30),
              Wrap(
                spacing: 10,
                runSpacing: 15,
                children: categories.map((e) {
                  bool isSelected = selected.contains(e.id);
                  return GestureDetector(
                    onTap: () {
                      if (isSelected)
                        selected.remove(e.id);
                      else if (selected.length < 5) {
                        selected.add(e.id);
                      } else {
                        Helpers.showSnackBar(
                            context, "Maximum of 5 already reached");
                      }
                      setState(() {});
                    },
                    child: Container(
                      child: AppTypography(
                        text: e.name,
                        textColor: isSelected ? primaryColor : chipTextColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 11.25, horizontal: 15),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? appTextInputFocusedBgColor
                            : chipBgColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            color: isSelected ? primaryColor : textInputColor,
                            width: 1),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Helpers.createSpacer(y: 45),
              AppButton(
                  child: isSaving
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : null,
                  disabled: isSaving,
                  onTapped: () async {
                    if (selected.isEmpty) {
                      Helpers.showSnackBar(
                          context, "Select at least 1 category");
                      return;
                    }
                    bool ans = await updateCategories();
                    if (!ans) {
                      Helpers.showSnackBar(context, "An error occured while");
                      return;
                    }
                    Navigator.pushNamed(context, "/onboarding_page_2");
                  },
                  buttonType: ButtonType.secondary,
                  text: "Save and Continue")
            ],
            // crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ));
  }
}
