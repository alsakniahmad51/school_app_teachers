import 'package:teachers_app/features/class/data/models/subject_class_model.dart';
import 'package:teachers_app/features/class/data/models/subject_teacher_model.dart';
import 'package:teachers_app/features/class/domain/entity/subject.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required super.id,
    required super.name,
    required super.comment,
    required super.fullMark,
    required super.subjectClass,
    required super.teachers,
    required super.filesCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      comment: json['comment'] ?? '',
      fullMark: json['full_mark'] ?? '0',
      subjectClass: SubjectClassModel.fromJson(json['class']),
      teachers: (json['teachers'] as List)
          .map((e) => SubjectTeacherModel.fromJson(e))
          .toList(),
      filesCount: json['files_count'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
