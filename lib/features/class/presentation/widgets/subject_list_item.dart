import 'package:flutter/material.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/features/course/presentation/pages/course_details_page.dart';

class SubjectListItem extends StatelessWidget {
  final String courseTitle;
  final String subtitle;

  const SubjectListItem({
    super.key,
    required this.courseTitle,
    this.subtitle = 'عرض المادة',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigationWithFade(CourseDetailsPage(courseTitle: courseTitle));
      },
      child: Container(
        width: 372,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.chevron_left_rounded,
                  size: 12,
                  color: Color(0xFF007353),
                ),
                const SizedBox(width: 4),
                Text(
                  subtitle,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF007353),
                    height: 1.5,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      courseTitle,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000F0B),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F7F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 20,
                      color: Color(0xFF007353),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
