import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';
import 'package:teachers_app/features/home/domain/repo/sections_repo.dart';

class GetTeacherSectionsUseCase {
  final SectionsRepo repository;

  GetTeacherSectionsUseCase(this.repository);

  Future<Either<Failure, TeacherSections>> call() async {
    return await repository.getTeacherSections();
  }
}
