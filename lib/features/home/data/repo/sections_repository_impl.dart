import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';

import 'package:teachers_app/features/home/data/datasources/sections_remote_data_source.dart';
import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';
import 'package:teachers_app/features/home/domain/repo/sections_repo.dart';

class SectionsRepositoryImpl implements SectionsRepo {
  final SectionsRemoteDataSource remoteDataSource;

  SectionsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TeacherSections>> getTeacherSections() async {
    try {
      final model = await remoteDataSource.getTeacherSections();
      return Right(
        TeacherSections(
          teacherId: model.teacherId,
          teacherName: model.teacherName,
          total: model.total,
          sections: model.sections,
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
