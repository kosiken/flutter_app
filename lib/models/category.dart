import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends ModelBase {
  final String name;
  final String icon;
  final int id;
  final int type;

  const Category(
      {required this.id,
      required this.icon,
      required this.name,
      required this.type});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String tableName() {
    return "category";
  }
}
