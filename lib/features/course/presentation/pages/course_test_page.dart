import 'package:flutter/material.dart';

import '../widgets/course_test.dart';
import '../widgets/course_test_card.dart';

class CourseTestsPage extends StatelessWidget {
  const CourseTestsPage({super.key, this.tests = _defaultTests});

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
    ),
    CourseTest(
      title: 'فحص نهائي',
      status: CourseTestStatus.published,
      date: 'الأحد، 2025/06/06',
      time: '08:30 AM → 10:30 AM',
      rooms: 'الأولى، الثانية، الخامسة، السادسة',
      studentCount: 32,
      teacher: 'الأستاذ محمد سعيد',
      supervisor: 'المشرف: راشد زكي الأحمد',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: tests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          CourseTestCard(test: tests[index], onPressed: () {}),
    );
  }
}
