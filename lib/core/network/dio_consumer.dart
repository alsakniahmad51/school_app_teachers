import 'package:dio/dio.dart';

import '../constants/app_constants.dart';

class DioConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options.connectTimeout = AppConstants.requestTimeout;
    dio.options.receiveTimeout = AppConstants.requestTimeout;
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.get<T>(path, queryParameters: queryParameters, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
