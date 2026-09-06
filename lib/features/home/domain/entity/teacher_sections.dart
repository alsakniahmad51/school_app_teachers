import 'package:teachers_app/features/home/domain/entity/section.dart';

class TeacherSections {
  final int teacherId;
  final String teacherName;
  final List<Section> sections;
  final int total;

  const TeacherSections({
    required this.teacherId,
    required this.teacherName,
    required this.sections,
    required this.total,
  });
}
