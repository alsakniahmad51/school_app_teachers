import 'package:flutter/material.dart';

import 'course_test.dart';

class TestStatusBadge extends StatelessWidget {
  const TestStatusBadge({super.key, required this.status});

  final CourseTestStatus status;

  @override
  Widget build(BuildContext context) {
    final isPublished = status == CourseTestStatus.published;
    final color = isPublished
        ? const Color(0xff00a63e)
        : const Color(0xff14b8a6);
    final background = isPublished
        ? const Color(0xffe0f4e7)
        : const Color(0xfff1fbfa);

    return Container(
      width: 96,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(500),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                isPublished ? 'تم النشر' : 'تم الرفع للإدارة',
                maxLines: 1,
                style: TextStyle(
                  color: color,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
