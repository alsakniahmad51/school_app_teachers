import 'package:teachers_app/features/course/data/models/subject_class_global_model.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';

class SubjectGlobalModel extends SubjectGlobal {
  const SubjectGlobalModel({
    required super.id,
    required super.name,
    required super.comment,
    required super.fullMark,
    required super.classId,
    required super.createdAt,
    required super.updatedAt,
    required super.subjectClass,
  });

  factory SubjectGlobalModel.fromJson(Map<String, dynamic> json) {
    return SubjectGlobalModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      comment: json['comment'] ?? '',
      fullMark: json['full_mark'] ?? '',
      classId: json['class_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      subjectClass: SubjectClassGlobalModel.fromJson(json['class']),
    );
  }
}
