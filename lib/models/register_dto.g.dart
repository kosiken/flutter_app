// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDTO _$RegisterDTOFromJson(Map<String, dynamic> json) => RegisterDTO()
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..aka = json['aka'] as String
  ..phoneNumber = json['phoneNumber'] as String
  ..countryOfResidence = json['countryOfResidence'] as String
  ..primaryCelebrityCategory = json['primaryCelebrityCategory'] == null
      ? null
      : Category.fromJson(
          json['primaryCelebrityCategory'] as Map<String, dynamic>)
  ..password = json['password'] as String;

Map<String, dynamic> _$RegisterDTOToJson(RegisterDTO instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'aka': instance.aka,
      'phoneNumber': instance.phoneNumber,
      'countryOfResidence': instance.countryOfResidence,
      'primaryCelebrityCategory': instance.primaryCelebrityCategory,
      'password': instance.password,
    };
