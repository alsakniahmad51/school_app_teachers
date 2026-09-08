import 'package:teachers_app/features/course/domain/entity/subject_class_global.dart';

class SubjectClassGlobalModel extends SubjectClassGlobal {
  const SubjectClassGlobalModel({
    required super.id,
    required super.name,
    required super.comment,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubjectClassGlobalModel.fromJson(Map<String, dynamic> json) {
    return SubjectClassGlobalModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
