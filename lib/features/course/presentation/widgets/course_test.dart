import 'test_details_models.dart';

enum CourseTestStatus { submittedToManagement, published }

class CourseTest {
  const CourseTest({
    required this.title,
    required this.status,
    required this.date,
    required this.time,
    required this.rooms,
    required this.studentCount,
    required this.teacher,
    required this.supervisor,
    this.studentMarks = const [],
  });

  final String title;
  final CourseTestStatus status;
  final String date;
  final String time;
  final String rooms;
  final int studentCount;
  final String teacher;
  final String supervisor;
  final List<StudentMarkItem> studentMarks;
}
