import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = "en",
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': 'ar',
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
