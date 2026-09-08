import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/class/domain/entity/subject.dart';

abstract class SubjectsRepo {
  Future<Either<Failure, List<Subject>>> getSubjectsByClassAndSection(
    int classId,
    int sectionId,
  );
}
