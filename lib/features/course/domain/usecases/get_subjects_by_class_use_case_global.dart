import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';
import 'package:teachers_app/features/course/domain/repo/subjects_global_repo.dart';

class GetSubjectsByClassUseCaseGlobal {
  final SubjectsGlobalRepo repository;

  GetSubjectsByClassUseCaseGlobal(this.repository);

  Future<Either<Failure, List<SubjectGlobal>>> call(int classId) async {
    return await repository.getSubjectsByClass(classId);
  }
}
