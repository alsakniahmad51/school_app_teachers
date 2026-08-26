import 'package:dio/dio.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_consumer.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dioConsumer;

  AuthRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioConsumer.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    final data = response.data as Map<String, dynamic>;
    return UserModel.fromJson(data['user'] ?? data);
  }
}
