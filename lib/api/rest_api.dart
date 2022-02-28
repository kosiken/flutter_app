import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/api/base_api.dart';
import 'package:flutter_app/api/local_storage.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/celebrity_service.dart';
import 'package:flutter_app/models/person.dart';
import 'package:flutter_app/models/register_dto.dart';

class RestApi extends BaseApi {
  RestApi() : super(storage: DefaultStorage.instance) {
    init();
  }

  RestApi.withStorage({required Storage storage}) : super(storage: storage);

  Future<ApiResponse<bool>> updateProfile(
      String id, Map<String, dynamic> fieldsToUpdate) async {
    Map<String, dynamic> requestBody = {"id": id, ...fieldsToUpdate};
    Response<Map<String, dynamic>>? response;

    try {
      response = await dio.put("/User/account/celebrity/update",
          data: jsonEncode(requestBody),
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      return ApiResponse<bool>(
          message: response.data!["message"] as String,
          isError: response.data!["isError"] as bool,
          code: response.data!["code"] as int,
          result: response.statusCode == 200);
    } catch (err) {
      Debug.log(err);
      return ApiResponse<bool>(
          isError: true,
          message: "An error occurred",
          code: response?.statusCode ?? -1,
          result: false);
    }
  }

  Future<ApiResponse<bool>> updateBank(Map<String, dynamic> requestBody) async {
    Response<Map<String, dynamic>>? response;

    try {
      response = await dio.post("/Payment/bank/add",
          data: jsonEncode(requestBody),
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      return ApiResponse<bool>(
          message: response.data!["message"] as String,
          isError: response.data!["isError"] as bool,
          code: response.data!["code"] as int,
          result: response.statusCode == 200);
    } catch (err) {
      Debug.log((err as DioError).response!.data);
      return ApiResponse<bool>(
          isError: true,
          message: "An error occurred",
          code: response?.statusCode ?? -1,
          result: false);
    }
  }

  Future<ApiResponse<List<Category>>> getCategories(int type) async {
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.get("/App/categories/$type");

      return ApiResponse(
          message: response.data!["message"] as String,
          isError: response.data!["isError"] as bool,
          code: response.data!["code"] as int,
          result: (response.data!["result"] as List<dynamic>)
              .map((json) => Category.fromJson(json))
              .toList()
              .cast<Category>());
    } catch (err) {
      Debug.log(err);
      return ApiResponse<List<Category>>(
          isError: true,
          message: "An error occurred",
          code: response?.statusCode ?? -1);
    }
  }

  Future<ApiResponse<Person?>> register(RegisterDTO dto) async {
    Response<Map<String, dynamic>>? response;

    try {
      response = await dio.post("/User/account/signup", data: dto.toJson());
      Debug.log(response.data);

      final person = Person.fromJson(response.data!["result"]!["user"]);

      login(response.data!["result"]!["token"]!,
          response.data!["result"]!["expiry"]!);

      final ApiResponse<Person> apiResponse = ApiResponse(
          message: response.data!["message"] as String,
          isError: response.data!["isError"] as bool,
          code: response.data!["code"] as int,
          result: person);
      return apiResponse;
    } catch (e) {
      Debug.log(e);

      return ApiResponse<Person>(
          isError: true,
          message: "An error occurred",
          code: response?.statusCode ?? -1);
    }
  }

  Future<ApiResponse<List<CelebrityService>?>> getServices() async {
    Response<Map<String, dynamic>>? response;

    try {
      response = await dio.get("/App/amaze/services",
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));
      return ApiResponse(
          message: response.data!["message"] as String,
          isError: response.data!["isError"] as bool,
          code: response.data!["code"] as int,
          result: (response.data!["result"] as List<dynamic>)
              .map((json) => CelebrityService.fromJson(json))
              .toList()
              .cast<CelebrityService>());
    } catch (e) {
      Debug.log(e);

      return ApiResponse<List<CelebrityService>>(
          isError: true,
          message: "An error occurred",
          code: response?.statusCode ?? -1);
    }
  }
}
