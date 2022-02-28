// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: unused_element
RegisterDTO _$RegisterDTOFromJson(Map<String, dynamic> json) => RegisterDTO()
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..celebrityAKA = json['celebrityAKA'] as String
  ..phoneNumber = json['phoneNumber'] as String
  ..location = json['location'] as String
  ..countryOfResidence = json['countryOfResidence'] as String
  ..email = json['email'] as String
  ..primaryCelebrityCategory = Category.fromJson(
      json['primaryCelebrityCategory'] as Map<String, dynamic>)
  ..password = json['password'] as String;

Map<String, dynamic> _$RegisterDTOToJson(RegisterDTO instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'celebrityAKA': instance.celebrityAKA,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
      'countryOfResidence': instance.countryOfResidence,
      'email': instance.email,
      'primaryCelebrityCategory':
          RegisterDTO.categoryToJson(instance.primaryCelebrityCategory),
      'password': instance.password,
    };
