import 'package:flutter/material.dart';

import 'home_colors.dart';

class GradeSwitcher extends StatelessWidget {
  const GradeSwitcher({
    super.key,
    required this.selectedGrade,
    required this.onGradeSelected,
  });

  final String selectedGrade;
  final ValueChanged<String> onGradeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: ["الصف السابع", "الصف الثامن", "الصف التاسع"].map((grade) {
        final isSelected = grade == selectedGrade;
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Semantics(
            button: true,
            selected: isSelected,
            label: 'الصف $grade',
            child: Material(
              color: isSelected ? HomeColors.brand : HomeColors.surface,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () => onGradeSelected(grade),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: isSelected
                        ? null
                        : Border.all(color: HomeColors.mutedBorder, width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'الصف ${_gradeName(grade)}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : HomeColors.primaryText,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _gradeName(String grade) => const {
    'الصف السابع': 'السابع',
    'الصف الثامن': 'الثامن',
    'الصف التاسع': 'التاسع',
  }[grade]!;
}
