import 'dart:convert';

import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends ModelBase {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? aka;
  final String? image;
  final String? email;
  final String? phoneNumber;
  final String? location;

  const Person(
      {required this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.location,
      this.aka,
      this.image,
      this.email});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String tableName() {
    return "users";
  }

  @override
  Map<String, dynamic> toDb() {
    return {"Role": "user", "data": jsonEncode(toJson())};
  }
}
