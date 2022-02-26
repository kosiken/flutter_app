import 'package:dio/dio.dart';
import 'package:flutter_app/api/api_constants.dart';
import 'package:flutter_app/api/local_storage.dart';

class ApiResponse<T> {
  final T? result;
  final String message;
  final bool isError;
  final int code;

  const ApiResponse(
      {this.result,
      required this.message,
      required this.isError,
      required this.code});

  @override
  String toString() {
    Map<String, dynamic> json = {
      "isError": isError,
      "message": message,
      "code": code,
      "result": result
    };
    return json.toString();
  }
}

class BaseApi {
  final dio = Dio(
    BaseOptions(baseUrl: devUrl, contentType: 'application/json'),
  );
  String? _token;
  DateTime? _expiry;
  final Storage storage;

  BaseApi({required this.storage});

  Future<void> init() async {
    _token = await storage.getItem("token");

    String? expiry = await storage.getItem("expiry");
    if (expiry != null) {
      _expiry = DateTime.parse(expiry);
    }
  }

  Future<void> login(String token, String expiry) async {
    _expiry = DateTime.parse(expiry);
    _token = token;
    await storage.setItem("expiry", expiry);
    await storage.setItem("token", token);
  }
}
