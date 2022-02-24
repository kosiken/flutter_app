import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends ModelBase {
  final String id;
  final String firstName;
  final String lastName;
  final String aka;
  final String image;

  const Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.aka,
    required this.image,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String tableName() {
    return "person";
  }
}
