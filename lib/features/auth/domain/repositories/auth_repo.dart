import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthUser>> login(String userName, String password);
}
