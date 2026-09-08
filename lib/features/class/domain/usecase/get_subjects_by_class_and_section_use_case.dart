import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/class/domain/entity/subject.dart';
import 'package:teachers_app/features/class/domain/repo/subjects_repo.dart';

class GetSubjectsByClassAndSectionUseCase {
  final SubjectsRepo repository;

  GetSubjectsByClassAndSectionUseCase(this.repository);

  Future<Either<Failure, List<Subject>>> call(
    int classId,
    int sectionId,
  ) async {
    return await repository.getSubjectsByClassAndSection(classId, sectionId);
  }
}
