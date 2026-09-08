import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/class/data/datasource/subjects_remote_data_source.dart';
import 'package:teachers_app/features/class/domain/entity/subject.dart';
import 'package:teachers_app/features/class/domain/repo/subjects_repo.dart';

class SubjectsRepositoryImpl implements SubjectsRepo {
  final SubjectsRemoteDataSource remoteDataSource;

  SubjectsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Subject>>> getSubjectsByClassAndSection(
    int classId,
    int sectionId,
  ) async {
    try {
      final models = await remoteDataSource.getSubjectsByClassAndSection(
        classId,
        sectionId,
      );
      final subjects = models
          .map(
            (model) => Subject(
              id: model.id,
              name: model.name,
              comment: model.comment,
              fullMark: model.fullMark,
              subjectClass: model.subjectClass,
              teachers: model.teachers,
              filesCount: model.filesCount,
              createdAt: model.createdAt,
              updatedAt: model.updatedAt,
            ),
          )
          .toList();
      return Right(subjects);
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioExceptions(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
