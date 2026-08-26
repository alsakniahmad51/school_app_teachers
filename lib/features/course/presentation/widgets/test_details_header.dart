import 'package:flutter/material.dart';

class TestDetailsHeader extends StatelessWidget {
  const TestDetailsHeader({
    super.key,
    required this.courseTitle,
    required this.testTitle,
    required this.onBack,
  });

  final String courseTitle;
  final String testTitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onBack,
            visualDensity: VisualDensity.compact,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(
              Icons.chevron_left,
              color: Color(0xff000f0b),
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    courseTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xff0a0600),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    testTitle,
                    style: const TextStyle(
                      color: Color(0xff000f0b),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.33,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
