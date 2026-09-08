import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/files_remote_data_source.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

class DeleteSubjectFileUseCase {
  final FilesRemoteDataSource remoteDataSource;

  DeleteSubjectFileUseCase(this.remoteDataSource);

  Future<Either<Failure, Unit>> call(SubjectFile file) async {
    try {
      await remoteDataSource.deleteFile(file.id, file.name);
      return const Right(unit);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
