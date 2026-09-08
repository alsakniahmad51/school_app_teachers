import 'package:teachers_app/features/home/domain/entity/section.dart';

class SectionModel extends Section {
  const SectionModel({
    required super.id,
    required super.name,
    required super.classId,
    required super.className,
    required super.comment,
    required super.createdAt,
    required super.updatedAt,
    required super.totalStudents,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      classId: json['class_id'] ?? 0,
      className: json['class_name'] ?? '',
      comment: json['comment'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      totalStudents: json['students_count'] ?? 0,
    );
  }
}
