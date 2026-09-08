import 'package:teachers_app/features/course/domain/entity/subject_class_global.dart';

class SubjectGlobal {
  final int id;
  final String name;
  final String comment;
  final String fullMark;
  final int classId;
  final String createdAt;
  final String updatedAt;
  final SubjectClassGlobal subjectClass;

  const SubjectGlobal({
    required this.id,
    required this.name,
    required this.comment,
    required this.fullMark,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.subjectClass,
  });
}
