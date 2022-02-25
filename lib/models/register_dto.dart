import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDTO extends ModelBase {
  String firstName = "";
  String lastName = "";
  String aka = "";
  String phoneNumber = "";
  String countryOfResidence = "";
  Category? primaryCelebrityCategory;
  String password = "";

  RegisterDTO(); // empty constructor
  @override
  String tableName() {
    return "register_dto";
  }

  @override
  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);

  factory RegisterDTO.fromJson(Map<String, dynamic> json) =>
      _$RegisterDTOFromJson(json);
}
