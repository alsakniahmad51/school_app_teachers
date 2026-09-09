import 'package:flutter/material.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';

import 'test_info_chip.dart';

class CourseTestCard extends StatelessWidget {
  const CourseTestCard({super.key, required this.test, this.onPressed});
  final VoidCallback? onPressed;
  final Exam test;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    test.examType,
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
                  TestInfoChip(icon: Icons.access_time, text: test.duration),
                  const SizedBox(width: 8),
                  TestInfoChip(
                    icon: Icons.calendar_today_outlined,
                    text: test.date,
                  ),
                ],
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
      ),
    );
  }
}
