import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/files_remote_data_source.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

class DownloadSubjectFileUseCase {
  final FilesRemoteDataSource remoteDataSource;

  DownloadSubjectFileUseCase(this.remoteDataSource);

  Future<Either<Failure, String>> call(int fileId, String fileName) async {
    try {
      return Right(await remoteDataSource.downloadFile(fileId, fileName));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  Future<bool> isDownloaded(SubjectFile file) {
    return remoteDataSource.isFileDownloaded(file.id, file.name);
  }
}
