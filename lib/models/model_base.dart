abstract class ModelBase {
  Map<String, dynamic> toJson();

  const ModelBase();

  String tableName();

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toDb() {
    return {};
  }
}
