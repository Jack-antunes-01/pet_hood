import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_hood/database/api_adapter_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiAdapter implements ApiAdapterInterface {
  final Dio _apiAdapter = Dio();

  ApiAdapter() {
    _apiAdapter.options.baseUrl = dotenv.env['API']!;
    addInterceptors();
  }

  void addInterceptors() {
    _apiAdapter.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) async {
      if (options.headers.containsKey("requiresToken") &&
          !!options.headers['requiresToken']) {
        options.headers.remove("requiresToken");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.get("token");

        options.headers['Authorization'] = 'Bearer: $token';
      }
      handler.next(options);
    }));
  }

  final String apiUrl = dotenv.env['API']!;

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _apiAdapter.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _apiAdapter.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _apiAdapter.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _apiAdapter.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
