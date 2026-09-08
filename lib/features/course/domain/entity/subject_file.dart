class SubjectFile {
  final int id;
  final String name;
  final int subjectId;
  final String filePath;
  final String createdAt;
  final String updatedAt;
  final String downloadUrl;

  const SubjectFile({
    required this.id,
    required this.name,
    required this.subjectId,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
    required this.downloadUrl,
  });
}
