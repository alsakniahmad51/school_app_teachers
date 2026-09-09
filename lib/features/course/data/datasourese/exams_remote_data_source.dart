import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/models/bulk_exam_model.dart';
import 'package:teachers_app/features/course/data/models/exam_model.dart';

abstract class ExamsRemoteDataSource {
  Future<List<ExamModel>> getExamsList(int subjectId);
  Future<String> addBulkExam(BulkExamModel bulkExam);
}

class ExamsRemoteDataSourceImpl implements ExamsRemoteDataSource {
  final DioConsumer dio;

  ExamsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ExamModel>> getExamsList(int subjectId) async {
    final response = await dio.get(
      "api/dashboard/student-subjects/subject/$subjectId/exams-list",
    );

    final List exams = response['data']['exams'];

    return exams.map((exam) => ExamModel.fromJson(exam)).toList();
  }

  @override
  Future<String> addBulkExam(BulkExamModel bulkExam) async {
    final response = await dio.post(
      "api/dashboard/student-subjects/bulk",
      data: bulkExam.toJson(),
    );

    return response['message'] ?? '';
  }
}
