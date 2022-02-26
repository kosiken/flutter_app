// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location: json['location'] as String?,
      aka: json['aka'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'aka': instance.aka,
      'image': instance.image,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
    };
