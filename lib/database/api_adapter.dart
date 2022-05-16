import 'package:dio/dio.dart';
import 'package:pet_hood/database/api_adapter_interface.dart';

class ApiAdapter implements ApiAdapterInterface {
  final Dio _apiAdapter = Dio();

  final String apiUrl = "http://localhost:3333";

  @override
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiAdapter.delete(
      apiUrl + path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiAdapter.get(
      apiUrl + path,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiAdapter.post(
      apiUrl + path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _apiAdapter.put(
      apiUrl + path,
      data: data,
      queryParameters: queryParameters,
    );
  }
}
