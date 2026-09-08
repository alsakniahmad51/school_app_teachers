import 'package:teachers_app/features/class/domain/entity/subject_class.dart';

class SubjectClassModel extends SubjectClass {
  const SubjectClassModel({required super.id, required super.name});

  factory SubjectClassModel.fromJson(Map<String, dynamic> json) {
    return SubjectClassModel(id: json['id'] ?? 0, name: json['name'] ?? '');
  }
}
