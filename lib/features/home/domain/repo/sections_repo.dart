import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';

import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';

abstract class SectionsRepo {
  Future<Either<Failure, TeacherSections>> getTeacherSections();
}
