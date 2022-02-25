import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDTO extends ModelBase {
  String firstName = "";
  String lastName = "";
  String celebrityAKA = "";
  String phoneNumber = "";
  String location = "";
  String countryOfResidence = "";
  String email = "";

  @JsonKey(toJson: categoryToJson)
  late Category primaryCelebrityCategory;
  String password = "";

  RegisterDTO(); // empty constructor
  @override
  String tableName() {
    return "register_dto";
  }

  @override
  Map<String, dynamic> toJson() => _$RegisterDTOToJson(this);

  static int categoryToJson(Category category) {
    return category.id;
  }
}
