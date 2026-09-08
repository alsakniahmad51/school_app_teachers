import 'package:teachers_app/features/class/domain/entity/subject_teacher.dart';

class SubjectTeacherModel extends SubjectTeacher {
  const SubjectTeacherModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
  });

  factory SubjectTeacherModel.fromJson(Map<String, dynamic> json) {
    return SubjectTeacherModel(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}
