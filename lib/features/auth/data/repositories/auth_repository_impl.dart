import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:teachers_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:teachers_app/features/auth/data/models/login_request_model.dart';
import 'package:teachers_app/features/auth/domain/entities/auth_user.dart';

class AuthRepositoryImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthUser>> login(
    String userName,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.login(
        LoginRequestModel(userName: userName, password: password),
      );
      return Right(
        AuthUser(
          message: model.message,
          accessToken: model.accessToken,
          id: model.id,
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioExceptions(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
