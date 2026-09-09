import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';
import 'package:teachers_app/features/course/domain/repo/exams_repo.dart';

class GetExamsListUseCase {
  final ExamsRepo repository;

  GetExamsListUseCase(this.repository);

  Future<Either<Failure, List<Exam>>> call(int subjectId) async {
    return await repository.getExamsList(subjectId);
  }
}
