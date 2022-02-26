import 'package:flutter/material.dart';
import 'package:flutter_app/helpers.dart';
import 'package:flutter_app/models/listable.dart';
import 'package:flutter_app/widgets/modal.dart';
import 'package:flutter_app/widgets/text_input.dart';
import 'package:flutter_app/widgets/typography.dart';

class SearchModal<T extends Listable> extends StatefulWidget {
  final List<T> models;
  final void Function(T model) onSelect;
  final double height;
  const SearchModal(
      {Key? key,
      required this.models,
      required this.onSelect,
      this.height = 500})
      : super(key: key);

  @override
  _SearchModalState<T> createState() => _SearchModalState<T>();
}

class _SearchModalState<T extends Listable> extends State<SearchModal<T>> {
  List<T> matches = [];

  @override
  void initState() {
    super.initState();
    matches.addAll(widget.models);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
        height: widget.height,
        borderRadius: 20,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          children: [
            AppTextInput(
              label: "Enter Country Name",
              onChange: (text) {
                if (text.isNotEmpty) {
                  matches = widget.models
                      .where((model) => model.toString().contains(text))
                      .toList()
                      .cast<T>();
                } else {
                  matches = widget.models;
                }
              },
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (c, i) {
                var item = matches[i];
                return ListTile(
                  leading: item.leading() != null
                      ? AppTypography(text: item.leading()!)
                      : const SizedBox(),
                  title: AppTypography(
                      text:
                          Helpers.shortenText(matches[i].title(), length: 25)),
                  trailing: item.trailing() != null
                      ? AppTypography(text: item.trailing()!)
                      : const SizedBox(),
                  onTap: () {
                    widget.onSelect(item);
                  },
                );
              },
              itemCount: matches.length,
            ))
          ],
        ));
  }
}
