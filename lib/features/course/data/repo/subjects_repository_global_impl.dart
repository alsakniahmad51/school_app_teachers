import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/subjects_remoteg_data_source.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';
import 'package:teachers_app/features/course/domain/repo/subjects_global_repo.dart';

class SubjectsGlobalRepositoryImpl implements SubjectsGlobalRepo {
  final SubjectsRemoteDataSourceGlobal remoteDataSource;

  SubjectsGlobalRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SubjectGlobal>>> getSubjectsByClass(
    int classId,
  ) async {
    try {
      final models = await remoteDataSource.getSubjectsByClass(classId);

      return Right(
        models
            .map(
              (model) => SubjectGlobal(
                id: model.id,
                name: model.name,
                comment: model.comment,
                fullMark: model.fullMark,
                classId: model.classId,
                createdAt: model.createdAt,
                updatedAt: model.updatedAt,
                subjectClass: model.subjectClass,
              ),
            )
            .toList(),
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
