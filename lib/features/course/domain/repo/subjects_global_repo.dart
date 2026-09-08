import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';

abstract class SubjectsGlobalRepo {
  Future<Either<Failure, List<SubjectGlobal>>> getSubjectsByClass(int classId);
}
