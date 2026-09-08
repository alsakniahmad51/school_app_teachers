import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/files_remote_data_source.dart';

class UploadSubjectFileUseCase {
  final FilesRemoteDataSource remoteDataSource;

  UploadSubjectFileUseCase(this.remoteDataSource);

  Future<Either<Failure, Unit>> call(
    int subjectId,
    String filePath,
    String fileName,
  ) async {
    try {
      await remoteDataSource.uploadFile(subjectId, filePath, fileName);
      return const Right(unit);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
