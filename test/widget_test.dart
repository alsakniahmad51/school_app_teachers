// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:teachers_app/features/course/presentation/pages/course_test_page.dart';
import 'package:teachers_app/features/course/presentation/widgets/course_test.dart';
import 'package:teachers_app/features/home/presentation/pages/home_page.dart';

void main() {
  testWidgets('home page switches the active grade tab', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    expect(find.text('الصف السابع'), findsOneWidget);
    expect(find.text('الشعبة الأولى'), findsOneWidget);

    await tester.tap(find.text('الصف الثامن'));
    await tester.pump();

    final selectedTab = tester.widget<Text>(find.text('الصف الثامن'));
    expect(selectedTab.style?.color, const Color(0xffffffff));
  });

  testWidgets('course test card renders its database status', (tester) async {
    const test = CourseTest(
      title: 'فحص نهائي',
      status: CourseTestStatus.published,
      date: 'الأحد، 2025/06/06',
      time: '08:30 AM → 10:30 AM',
      rooms: 'الأولى',
      studentCount: 32,
      teacher: 'الأستاذ محمد سعيد',
      supervisor: 'المشرف: راشد زكي الأحمد',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: CourseTestsPage(tests: [test], courseTitle: 'cscsc'),
      ),
    );

    expect(find.text('تم النشر'), findsOneWidget);
  });
}
