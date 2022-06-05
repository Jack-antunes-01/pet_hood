import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey("requiresToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresToken");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.get("token");

      options.headers.addAll({"Authorization": token});

      return options;
    }
  }
}
