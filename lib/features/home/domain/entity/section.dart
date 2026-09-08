class Section {
  final int id;
  final String name;
  final int classId;
  final String className;
  final String comment;
  final int totalStudents;
  final String createdAt;
  final String updatedAt;

  const Section({
    required this.id,
    required this.name,
    required this.classId,
    required this.className,
    required this.comment,

    required this.createdAt,
    required this.updatedAt,
    required this.totalStudents,
  });
}
