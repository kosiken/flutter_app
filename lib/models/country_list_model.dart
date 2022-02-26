import 'package:flutter_app/models/listable.dart';

class CountryLisModel extends Listable {
  final String code;
  final String name;
  final String flag;
  const CountryLisModel(this.code, this.name, this.flag);

  @override
  String toString() {
    return name;
  }

  @override
  String? leading() {
    return code;
  }

  @override
  String title() {
    return name;
  }

  @override
  String? trailing() {
    return flag;
  }
}
