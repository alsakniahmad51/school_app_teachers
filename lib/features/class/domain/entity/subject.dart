import 'package:teachers_app/features/class/domain/entity/subject_class.dart';
import 'package:teachers_app/features/class/domain/entity/subject_teacher.dart';

class Subject {
  final int id;
  final String name;
  final String comment;
  final String fullMark;
  final SubjectClass subjectClass;
  final List<SubjectTeacher> teachers;
  final int filesCount;
  final String createdAt;
  final String updatedAt;

  const Subject({
    required this.id,
    required this.name,
    required this.comment,
    required this.fullMark,
    required this.subjectClass,
    required this.teachers,
    required this.filesCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
