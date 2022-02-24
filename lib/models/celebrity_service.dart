import 'package:flutter_app/models/model_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'celebrity_service.g.dart';

@JsonSerializable()
class CelebrityStatus extends ModelBase {
  final int id;
  final String name;
  final String description;
  final double fanPrice;
  final double businessPrice;
  final bool isFeatured;

  const CelebrityStatus(
      {required this.id,
      required this.name,
      required this.description,
      required this.businessPrice,
      required this.fanPrice,
      required this.isFeatured});

  factory CelebrityStatus.fromJson(Map<String, dynamic> json) =>
      _$CelebrityStatusFromJson(json);

  Map<String, dynamic> toJson() => _$CelebrityStatusToJson(this);

  @override
  String tableName() {
    return "status";
  }
}
