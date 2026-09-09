import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/errors/exceptions.dart';
import 'package:teachers_app/features/course/data/datasourese/exams_remote_data_source.dart';
import 'package:teachers_app/features/course/data/models/bulk_exam_model.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';
import 'package:teachers_app/features/course/domain/repo/exams_repo.dart';

class ExamsRepositoryImpl implements ExamsRepo {
  final ExamsRemoteDataSource remoteDataSource;

  ExamsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Exam>>> getExamsList(int subjectId) async {
    try {
      final models = await remoteDataSource.getExamsList(subjectId);

      return Right(
        models
            .map(
              (model) => Exam(
                examType: model.examType,
                date: model.date,
                duration: model.duration,
              ),
            )
            .toList(),
      );
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioExceptions(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> addBulkExam(BulkExam bulkExam) async {
    try {
      final model = BulkExamModel(
        subjectId: bulkExam.subjectId,
        examType: bulkExam.examType,
        date: bulkExam.date,
        students: bulkExam.students,
      );

      final message = await remoteDataSource.addBulkExam(model);

      return Right(message);
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioExceptions(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
