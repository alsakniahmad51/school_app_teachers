import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

class SubjectFileModel extends SubjectFile {
  const SubjectFileModel({
    required super.id,
    required super.name,
    required super.subjectId,
    required super.filePath,
    required super.createdAt,
    required super.updatedAt,
    required super.downloadUrl,
  });

  factory SubjectFileModel.fromJson(Map<String, dynamic> json) {
    return SubjectFileModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      subjectId: json['subject_id'] ?? 0,
      filePath: json['file_path'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }
}
