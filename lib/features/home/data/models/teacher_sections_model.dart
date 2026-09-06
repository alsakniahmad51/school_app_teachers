import 'package:teachers_app/features/home/data/models/section_model.dart';
import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';

class TeacherSectionsModel extends TeacherSections {
  const TeacherSectionsModel({
    required super.teacherId,
    required super.teacherName,
    required super.sections,
    required super.total,
  });

  factory TeacherSectionsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return TeacherSectionsModel(
      teacherId: data['teacher_id'] ?? 0,
      teacherName: data['teacher_name'] ?? '',
      total: data['total'] ?? 0,
      sections: (data['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList(),
    );
  }
}
