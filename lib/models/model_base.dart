abstract class ModelBase {
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }

  const ModelBase();

  String tableName();

  @override
  String toString() {
    return toJson().toString();
  }
}
