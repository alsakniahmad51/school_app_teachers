import 'package:teachers_app/features/course/data/models/bulk_exam_student_model.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';

class BulkExamModel extends BulkExam {
  const BulkExamModel({
    required super.subjectId,
    required super.examType,
    required super.date,
    required super.students,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'exam_type': examType,
      'date': date,
      'students': students
          .map(
            (student) => BulkExamStudentModel(
              studentId: student.studentId,
              mark: student.mark,
              note: student.note,
            ).toJson(),
          )
          .toList(),
    };
  }
}
