import 'package:flutter/material.dart';
import 'package:flutter_app/constants/colors.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/state.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/typography.dart';
import 'package:provider/provider.dart';

class PageOne extends StatefulWidget {
  final List<Category> categories;

  const PageOne({Key? key, required this.categories}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<Category> categories = [];
  Person? _person;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories.addAll(widget.categories);
    _person = Provider.of<AppState>(context).user!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            text: "Please select the service(s) you choose to offer on Amaze",
            textColor: secondaryColor,
          ),
          Helpers.createSpacer(y: 30),
          Wrap(
            spacing: 10,
            runSpacing: 15,
            children: categories.map((e) {
              bool isSelected = false;
              return GestureDetector(
                onTap: () {},
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
          ),
          Helpers.createSpacer(y: 45),
          AppButton(
              onTapped: () {},
              buttonType: ButtonType.secondary,
              text: "Save and Continue")
        ],
        // crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
