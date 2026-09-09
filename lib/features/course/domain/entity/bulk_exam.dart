import 'package:teachers_app/features/course/domain/entity/bulk_exam_student.dart';

class BulkExam {
  final int subjectId;
  final String examType;
  final String date;
  final List<BulkExamStudent> students;

  const BulkExam({
    required this.subjectId,
    required this.examType,
    required this.date,
    required this.students,
  });
}
