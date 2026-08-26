import 'package:flutter/material.dart';

import 'home_colors.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: HomeColors.surface,
          border: Border.all(color: HomeColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: HomeColors.brandSoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.assignment_outlined,
                    color: HomeColors.brand,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: HomeColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'الموجه: أ. راشد الأحمد',
                            style: TextStyle(
                              color: HomeColors.secondaryText,
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '50 طالب',
                            style: TextStyle(
                              color: HomeColors.secondaryText,
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.school_outlined,
                            color: HomeColors.secondaryText,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: Container(
                decoration: BoxDecoration(
                  color: HomeColors.brand,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chevron_left, size: 16, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'عرض الشعبة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
