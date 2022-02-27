// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityService _$CelebrityServiceFromJson(Map<String, dynamic> json) =>
    CelebrityService(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      businessPrice: (json['businessPrice'] as num?)?.toDouble(),
      fanPrice: (json['fanPrice'] as num?)?.toDouble(),
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$CelebrityServiceToJson(CelebrityService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'fanPrice': instance.fanPrice,
      'businessPrice': instance.businessPrice,
      'isFeatured': instance.isFeatured,
    };
