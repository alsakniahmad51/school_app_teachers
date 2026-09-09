import 'package:teachers_app/features/course/domain/entity/exam.dart';

class ExamModel extends Exam {
  const ExamModel({
    required super.examType,
    required super.date,
    required super.duration,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examType: json['exam_type'] ?? '',
      date: json['date'] ?? '',
      duration: json['duration'] ?? '',
    );
  }
}
