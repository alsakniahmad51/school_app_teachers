import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';
import 'package:teachers_app/features/course/domain/repo/exams_repo.dart';

class AddBulkExamUseCase {
  final ExamsRepo repository;

  AddBulkExamUseCase(this.repository);

  Future<Either<Failure, String>> call(BulkExam bulkExam) async {
    return await repository.addBulkExam(bulkExam);
  }
}
