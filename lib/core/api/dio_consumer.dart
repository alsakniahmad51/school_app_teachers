import 'package:dio/dio.dart';
import 'package:teachers_app/core/api/api_consumer.dart';
import 'package:teachers_app/main.dart' show savedToken;

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: "https://unclasp-joyfully-confront.ngrok-free.dev/",
      // connectTimeout: const Duration(seconds: 30),
      // receiveTimeout: const Duration(seconds: 30),
      // sendTimeout: const Duration(seconds: 30),
      // headers: {'Content-Type': 'application/json'},
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await savedToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.delete(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.post(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.put(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    final response = await dio.patch(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      queryParameters: queryParameters,
    );

    return response.data;
  }
}
