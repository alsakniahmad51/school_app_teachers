import 'package:flutter/material.dart';

import 'course_test.dart';
import 'test_info_chip.dart';
import 'test_status_badge.dart';

class CourseTestCard extends StatelessWidget {
  const CourseTestCard({
    super.key,
    required this.test,
    required this.onPressed,
  });

  final CourseTest test;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffe0e0e0), width: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TestStatusBadge(status: test.status),
                Text(
                  test.title,
                  style: const TextStyle(
                    color: Color(0xff000f0b),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TestInfoChip(icon: Icons.access_time, text: test.time),
                const SizedBox(width: 8),
                TestInfoChip(
                  icon: Icons.calendar_today_outlined,
                  text: test.date,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                runSpacing: 4,
                children: [
                  TestInfoLine(
                    icon: Icons.people_outline,
                    text: '${test.studentCount} طالبًا',
                  ),
                  TestInfoLine(
                    icon: Icons.location_on_outlined,
                    text: 'القاعات: ${test.rooms}',
                  ),
                  TestInfoLine(
                    icon: Icons.menu_book_outlined,
                    text: test.teacher,
                  ),
                  TestInfoLine(
                    icon: Icons.menu_book_outlined,
                    text: test.supervisor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36,
              child: FilledButton(
                onPressed: onPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xff007353),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'عرض التفاصيل',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
