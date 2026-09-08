import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

abstract class FilesRepo {
  Future<Either<Failure, List<SubjectFile>>> getSubjectFiles(int subjectId);
}
