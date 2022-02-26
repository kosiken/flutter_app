import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/api/rest_api.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/constants/text.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/country_list_model.dart';
import 'package:flutter_app/models/register_dto.dart';
import 'package:flutter_app/widgets/modal.dart';
import 'package:flutter_app/widgets/page.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/search_modal.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:validators/validators.dart';

import '../debug.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // RegisterDTO registerDTO = RegisterDTO()..firstName = "Lion";
  final api = RestApi();
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "Register Screen Scaffold");

  final GlobalKey<AppTextInputState> _categoryKey =
      GlobalKey<AppTextInputState>(debugLabel: "category Key");
  String countryCode = "+234";
  String firstName = "";
  String lastName = "";
  String celebrityAKA = "";
  String phoneNumber = "";
  String countryOfResidence = "";
  String primaryCelebrityCategory = "";
  String email = "";
  String city = "";
  String password = "";
  List<CountryLisModel> countries = <CountryLisModel>[];
  List<Category> categories = [];
  int selectedId = -1;
  // bool modalOpen()

  final RegExp capitalLetters = RegExp(r"[A-Z]");

  final RegExp smallLetters = RegExp(r"[a-z]");
  final RegExp specialCharacters = RegExp(r"[@$%^*#!\(\)]");
  bool hasError = false;
  Map<String, String> validationErrors = [
    "firstName",
    "lastName",
    "celebrityAKA",
    "phoneNumber",
    "countryOfResidence",
    "primaryCelebrityCategory",
    "password",
    "email",
    "city"
  ].map((e) => {e: ""}).reduce((value, element) {
    value.addAll(element);
    return value;
  });

  void updateValidationError(String key, String value) {
    hasError = value.isNotEmpty;
    validationErrors[key] = value;
  }

  void submit() async {
    RegisterDTO registerDTO = RegisterDTO();

    if (firstName.length > 1) {
      registerDTO.firstName = firstName;
    } else {
      updateValidationError("firstName", "First name is required");
    }
    if (lastName.length > 1) {
      registerDTO.lastName = lastName;
    } else {
      updateValidationError("lastName", "Last name is required");
    }
    if (selectedId > -1) {
      registerDTO.primaryCelebrityCategory =
          categories.firstWhere((element) => element.id == selectedId);
    } else {
      updateValidationError("primaryCelebrityCategory", "Category is required");
    }
    if (celebrityAKA.isNotEmpty) {
      registerDTO.celebrityAKA = celebrityAKA;
    } else {
      updateValidationError("celebrityAKA", "AKA is required");
    }
    if (isEmail(email)) {
      registerDTO.email = email;
    } else {
      updateValidationError("email", "Enter a valid email");
    }
    if (city.isNotEmpty) {
      registerDTO.location = "$city";
    } else {
      updateValidationError("city", "Enter a valid city name");
    }

    if (countryOfResidence.isNotEmpty) {
      registerDTO.location += ", $countryOfResidence";
    } else {
      updateValidationError("countryOfResidence", "Enter a valid country name");
    }
    if (phoneNumber.length > 9) {
      registerDTO.phoneNumber =
          "$countryCode${phoneNumber.length > 10 ? phoneNumber.substring(1) : phoneNumber}";
    } else {
      updateValidationError("phoneNumber", "Enter a valid phoneNumber");
    }

    if (smallLetters.hasMatch(password) &&
        capitalLetters.hasMatch(password) &&
        specialCharacters.hasMatch(password)) {
      registerDTO.password = password;
    } else {
      updateValidationError("password", "Enter a valid password");
    }

    Debug.log(registerDTO);
    if (hasError) {
      setState(() {});
      return;
    }
  }

  void loadCategories() async {
    final response = await api.getCategories(0);
    if (mounted) {
      if (response.isError) {
        Helpers.showSnackBar(context, "An error occurred while loading");
      } else {
        categories.addAll(response.result!);
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Debug.log(validationErrors);
    loadCountries();
    loadCategories();
  }

  void loadCountries() async {
    final String countriesJson =
        await Helpers.loadAsset("assets/countries.json");
    if (mounted) {
      setState(() {
        countries = (List.from(jsonDecode(countriesJson)).map((json) =>
                CountryLisModel(json["code"]!, json["name"]!, json["flag"]!)))
            .toList();
      });
    }
  }

  void showCountryBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (c) {
          return SearchModal<CountryLisModel>(
              models: countries,
              onSelect: (country) {
                setState(() {
                  countryCode = country.code;
                });
                Navigator.pop(context);
              });
        });
  }

  void showCategoryBottomSheet() {
    final controller = _categoryKey.currentState!.controller;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (c) {
          return CategoryListWidget(
              categories: categories,
              selected: selectedId,
              onSelect: (category) {
                updateValidationError("primaryCelebrityCategory", "");
                setState(() {
                  selectedId = category.id;
                  controller.text = category.name;
                });

                Navigator.pop(context);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppPage(
        scaffoldKey: _scaffoldKey,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Helpers.createSpacer(y: 15),
            const Image(
              image: AssetImage("assets/mail.png"),
              height: 75,
              width: 100,
            ),
            Helpers.createSpacer(y: 20),
            const AppTypography(
              text: "Create an Account",
              textType: TextTypes.header,
              fontWeight: FontWeight.bold,
            ),
            Helpers.createSpacer(y: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: AppTypography(
                text:
                    "And access the richest collection of celebrities and amaze-ing people",
                textAlign: TextAlign.center,
              ),
            ),
            Helpers.createSpacer(y: 25),
            getNameRow(size.width),
            Helpers.createSpacer(y: 25),
            AppTextInput(
              label: "Celebrity Aka",
              onChange: (text) {
                celebrityAKA = text;
                if (text.isEmpty) {
                  validationErrors["celebrityAKA"] = "Please Enter AKA";
                } else {
                  validationErrors["celebrityAKA"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["celebrityAKA"]!,
            ),
            Helpers.createSpacer(y: 25),
            AppTextInput(
              label: "Email Address",
              onChange: (text) {
                email = text;
                if (text.isEmpty || !isEmail(text)) {
                  validationErrors["email"] = "Enter a valid email";
                } else {
                  validationErrors["email"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["email"]!,
            ),
            Helpers.createSpacer(y: 25),
            Row(
              children: [
                AppButton(
                  borderRadius: 5,
                  child: Row(children: [
                    Helpers.createSpacer(x: 5),
                    AppTypography(text: countryCode),
                    const Icon(Icons.keyboard_arrow_down, color: textInputColor)
                  ]),
                  onTapped: showCountryBottomSheet,
                  borderColor: textInputColor,
                  buttonBgColor: Colors.transparent,
                  buttonColor: appTextColor,
                ),
                Helpers.createSpacer(x: 20),
                Expanded(
                    child: AppTextInput(
                  maxLength: 11,
                  label: "Phone number",
                  onChange: (text) {
                    phoneNumber = text;
                    if (text.length < 10) {
                      validationErrors["phoneNumber"] =
                          "Input valid phone number";
                    } else {
                      validationErrors["phoneNumber"] = "";
                    }
                    setState(() {});
                  },
                ))
              ],
            ),
            Helpers.createSpacer(y: 25),
            AppTextInput(
              label: "Country Of Residence",
              onChange: (text) {
                countryOfResidence = text;
                if (text.isEmpty) {
                  validationErrors["countryOfResidence"] = "Enter a Country";
                } else {
                  validationErrors["countryOfResidence"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["countryOfResidence"]!,
            ),
            Helpers.createSpacer(y: 25),
            AppTextInput(
              label: "City",
              onChange: (text) {
                city = text;
                if (text.isEmpty) {
                  validationErrors["city"] = "Enter a City";
                } else {
                  validationErrors["city"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["city"]!,
            ),
            Helpers.createSpacer(y: 25),
            GestureDetector(
              onTap: showCategoryBottomSheet,
              child: AppTextInput(
                  key: _categoryKey,
                  label: "Primary Celebrity Category",
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  disabled: true,
                  warning: validationErrors["primaryCelebrityCategory"]!,
                  right: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: const BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16,
                    ),
                  )),
            ),
            Helpers.createSpacer(y: 25),
            AppTextInput(
              label: "Password",
              secure: true,
              onChange: (text) {
                password = text;
                setState(() {});
              },
            ),
            Helpers.createSpacer(y: 25),
            Wrap(
              spacing: 8.0,
              runSpacing: 8,
              children: [
                if (capitalLetters.hasMatch(password)) capitalLettersText,
                if (smallLetters.hasMatch(password)) smallLettersText,
                if (specialCharacters.hasMatch(password)) specialCharactersText
              ]
                  .map(
                    (e) => Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        color: const Color.fromRGBO(41, 155, 1, 0.05),
                        child: _PasswordIndicators(text: e)),
                  )
                  .toList(),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: AppTypography.generateTextStyle(),
                    children: const <TextSpan>[
                      TextSpan(
                        text: termsText,
                      ),
                      TextSpan(
                          text: termsOfService,
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline)),
                      TextSpan(text: and),
                      TextSpan(
                          text: privacyPolicy,
                          style: TextStyle(
                              color: primaryColor,
                              decoration: TextDecoration.underline)),
                    ])),
            Helpers.createSpacer(y: 25),
            AppButton(
                text: continueText,
                onTapped: submit,
                buttonType: ButtonType.secondary,
                left: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(27.5)),
                        color: Colors.white,
                        border: Border.all(color: secondaryColor, width: 1)),
                    child: const Center(
                      child: Icon(
                        Icons.mail,
                        color: secondaryColor,
                      ),
                    ))),
            Helpers.createSpacer(y: 25),
          ],
        ))));
  }

  Widget getNameRow(double width) {
    if (width < 320) {
      // Handle situations where screen may be too small for inputs
      return Column(
        children: [
          AppTextInput(
            label: "First Name",
            onChange: (text) {
              firstName = text;
              if (text.isEmpty || text.length < 2) {
                validationErrors["firstName"] = "Please enter first name";
              } else {
                validationErrors["firstName"] = "";
              }
              setState(() {});
            },
            warning: validationErrors["firstName"]!,
          ),
          AppTextInput(
            label: "Last Name",
            onChange: (text) {
              lastName = text;
              if (text.isEmpty || text.length < 2) {
                validationErrors["lastName"] = "Please enter last name";
              } else {
                validationErrors["lastName"] = "";
              }
              setState(() {});
            },
            warning: validationErrors["lastName"]!,
          ),
        ],
      );
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: AppTextInput(
              label: "First Name",
              onChange: (text) {
                firstName = text;
                if (text.isEmpty || text.length < 2) {
                  validationErrors["firstName"] = "Please enter first name";
                } else {
                  validationErrors["firstName"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["firstName"]!,
            ),
          ),
          SizedBox(
            width: 180,
            child: AppTextInput(
              label: "Last Name",
              onChange: (text) {
                lastName = text;
                if (text.isEmpty || text.length < 2) {
                  validationErrors["lastName"] = "Please enter last name";
                } else {
                  validationErrors["lastName"] = "";
                }
                setState(() {});
              },
              warning: validationErrors["lastName"]!,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class _PasswordIndicators extends StatelessWidget {
  final String text;

  const _PasswordIndicators({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.horizontal,
      children: [
        const Icon(
          Icons.check,
          color: greenColor,
          size: 15,
        ),
        Helpers.createSpacer(x: 4),
        AppTypography(
          text: text,
          textType: TextTypes.small,
          textColor: greenColor,
        ),
        Helpers.createSpacer(x: 1),
      ],
    );
  }
}

class CategoryListWidget extends StatefulWidget {
  final List<Category> categories;
  final int selected;
  final void Function(Category category) onSelect;
  const CategoryListWidget(
      {Key? key,
      required this.categories,
      required this.selected,
      required this.onSelect})
      : super(key: key);

  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  Category? selected;
  @override
  void initState() {
    super.initState();
    if (widget.selected > 0) {
      setState(() {
        selected = widget.categories
            .firstWhere((element) => element.id == widget.selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
        height: 600,
        borderRadius: 20,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: chipBgColor,
                          borderRadius: BorderRadius.circular(17.5)),
                      child: const Icon(
                        Icons.close,
                        color: Color.fromRGBO(0x97, 0x97, 0x97, 1),
                        size: 15,
                      ),
                    )),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            const Center(
                child: Image(
              width: 94,
              height: 94,
              image: Svg('assets/category.svg'),
            )),
            Helpers.createSpacer(y: 10),
            const AppTypography(
              text: primaryCelebrityCategory,
              textType: TextTypes.header,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            Helpers.createSpacer(y: 10),
            const Center(
              child: SizedBox(
                width: 210,
                child: AppTypography(
                  text: pleaseSelectPrimaryCategory,
                  textType: TextTypes.small,
                  textAlign: TextAlign.center,
                  textColor: chipTextColor,
                ),
              ),
            ),
            Helpers.createSpacer(y: 30),
            Expanded(
                child: Wrap(
              spacing: 10,
              runSpacing: 15,
              children: widget.categories.map((e) {
                bool isSelected =
                    selected != null ? selected!.id == e.id : false;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = e;
                    });
                  },
                  child: Container(
                    child: AppTypography(
                      text: e.name,
                      textColor: isSelected ? primaryColor : chipTextColor,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 11.25, horizontal: 15),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? appTextInputFocusedBgColor : chipBgColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: isSelected ? primaryColor : textInputColor,
                          width: 1),
                    ),
                  ),
                );
              }).toList(),
            )),
            Helpers.createSpacer(y: 10),
            AppButton(
              onTapped: () {
                if (selected != null) {
                  widget.onSelect(selected!);
                } else {
                  Navigator.pop(context);
                }
              },
              text: selectCategory,
            ),
            Helpers.createSpacer(y: 50),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}
