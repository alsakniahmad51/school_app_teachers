import 'package:dartz/dartz.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';

abstract class ExamsRepo {
  Future<Either<Failure, List<Exam>>> getExamsList(int subjectId);
  Future<Either<Failure, String>> addBulkExam(BulkExam bulkExam);
}
