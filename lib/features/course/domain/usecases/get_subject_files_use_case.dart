import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';
import 'package:teachers_app/features/course/domain/repo/files_repo.dart';

class GetSubjectFilesUseCase {
  final FilesRepo repository;

  GetSubjectFilesUseCase(this.repository);

  Future<Either<Failure, List<SubjectFile>>> call(int subjectId) async {
    return await repository.getSubjectFiles(subjectId);
  }
}
