import 'package:teachers_app/features/course/domain/entity/bulk_exam_student.dart';

class BulkExamStudentModel extends BulkExamStudent {
  const BulkExamStudentModel({
    required super.studentId,
    required super.mark,
    required super.note,
  });

  Map<String, dynamic> toJson() {
    return {'student_id': studentId, 'mark': mark, 'note': note};
  }
}
