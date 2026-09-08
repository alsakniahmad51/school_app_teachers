import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/files_remote_data_source.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';
import 'package:teachers_app/features/course/domain/repo/files_repo.dart';

class FilesRepositoryImpl implements FilesRepo {
  final FilesRemoteDataSource remoteDataSource;

  FilesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SubjectFile>>> getSubjectFiles(
    int subjectId,
  ) async {
    try {
      final models = await remoteDataSource.getSubjectFiles(subjectId);
      final files = models
          .map(
            (model) => SubjectFile(
              id: model.id,
              name: model.name,
              subjectId: model.subjectId,
              filePath: model.filePath,
              createdAt: model.createdAt,
              updatedAt: model.updatedAt,
              downloadUrl: model.downloadUrl,
            ),
          )
          .toList();
      return Right(files);
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioExceptions(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
