import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'celebrity_service.g.dart';

@JsonSerializable()
class CelebrityService extends ModelBase {
  final int id;
  final String name;
  final String description;
  final double? fanPrice;
  final double? businessPrice;
  final bool isFeatured;

  const CelebrityService(
      {required this.id,
      required this.name,
      required this.description,
      this.businessPrice,
      this.fanPrice,
      this.isFeatured = false});

  factory CelebrityService.fromJson(Map<String, dynamic> json) =>
      _$CelebrityServiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CelebrityServiceToJson(this);

  @override
  String tableName() {
    return "Service";
  }
}
