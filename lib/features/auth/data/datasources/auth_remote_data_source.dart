import 'package:teachers_app/features/auth/data/models/auth_user_model.dart';
import 'package:teachers_app/features/auth/data/models/login_request_model.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserModel> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioConsumer dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthUserModel> login(LoginRequestModel request) async {
    final response = await dio.post("api/login", data: request.toJson());
    return AuthUserModel.fromJson(response);
  }
}
