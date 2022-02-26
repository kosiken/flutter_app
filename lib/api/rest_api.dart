import 'package:dio/dio.dart';
import 'package:flutter_app/api/base_api.dart';
import 'package:flutter_app/api/local_storage.dart';
import 'package:flutter_app/debug.dart';
import 'package:flutter_app/models/category.dart';

class RestApi extends BaseApi {
  RestApi() : super(storage: DefaultStorage.instance) {
    init();
  }

  RestApi.withStorage({required Storage storage}) : super(storage: storage);

  Future<ApiResponse<List<Category>>> getCategories(int type) async {
    Response<Map<String, dynamic>>? response;
    try {
      response = await dio.get("/api/App/categories/$type");

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
}
