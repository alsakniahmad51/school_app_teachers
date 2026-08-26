import 'package:flutter/material.dart';

import 'test_details_page.dart';
import '../widgets/course_test.dart';
import '../widgets/course_test_card.dart';
import '../widgets/test_details_models.dart';

class CourseTestsPage extends StatelessWidget {
  const CourseTestsPage({
    super.key,
    required this.courseTitle,
    this.tests = _defaultTests,
  });

  final String courseTitle;
  final List<CourseTest> tests;

  static const _defaultTests = [
    CourseTest(
      title: 'فحص نهائي',
      status: CourseTestStatus.submittedToManagement,
      date: 'الأحد، 2025/06/06',
      time: '08:30 AM → 10:30 AM',
      rooms: 'الأولى، الثانية، الخامسة، السادسة',
      studentCount: 32,
      teacher: 'الأستاذ محمد سعيد',
      supervisor: 'المشرف: راشد زكي الأحمد',
      studentMarks: [
        StudentMarkItem(
          id: 1,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 68,
          noteExpanded: true,
        ),
        StudentMarkItem(
          id: 2,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: null,
          statusOverride: StudentResultStatus.failed,
        ),
        StudentMarkItem(
          id: 3,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 80,
        ),
        StudentMarkItem(
          id: 4,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 24,
        ),
        StudentMarkItem(
          id: 5,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 39,
        ),
        StudentMarkItem(
          id: 6,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 60,
        ),
        StudentMarkItem(
          id: 7,
          studentName: 'أحمد علي الأحمد',
          maxScore: 100,
          score: 50,
        ),
      ],
    ),
    CourseTest(
      title: 'اختبار نصفي',
      status: CourseTestStatus.published,
      date: 'الاثنين، 2025/07/01',
      time: '09:00 AM → 11:00 AM',
      rooms: 'الثالثة، الرابعة',
      studentCount: 28,
      teacher: 'الأستاذ محمد سعيد',
      supervisor: 'المشرف: راشد زكي الأحمد',
      studentMarks: [
        StudentMarkItem(
          id: 1,
          studentName: 'سليم محمود',
          maxScore: 100,
          score: 92,
        ),
        StudentMarkItem(
          id: 2,
          studentName: 'جنى أحمد',
          maxScore: 100,
          score: 75,
        ),
        StudentMarkItem(
          id: 3,
          studentName: 'أحمد علي',
          maxScore: 100,
          score: 44,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: tests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final selectedTest = tests[index];
        return CourseTestCard(
          test: selectedTest,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TestDetailsPage(
                  courseTitle: courseTitle,
                  testTitle: selectedTest.title,
                  initialStudents: selectedTest.studentMarks,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
