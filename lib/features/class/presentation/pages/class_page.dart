import 'package:flutter/material.dart';
import 'package:teachers_app/features/class/presentation/widgets/class_header.dart';

import '../widgets/semester_switcher.dart';
import '../widgets/subject_list_item.dart';
import '../widgets/summary_card.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const ClassHeader(),
              const SizedBox(height: 12),
              const SemesterSwitcher(),
              const SizedBox(height: 12),

              const SubjectListItem(courseTitle: 'الفقه والشريعة'),
              const SizedBox(height: 8),
              const SubjectListItem(courseTitle: 'الأخلاق والمعاملات'),
              const SizedBox(height: 8),
              const SubjectListItem(courseTitle: 'التاريخ الإسلامي'),
            ],
          ),
        ),
      ),
    );
  }
}
