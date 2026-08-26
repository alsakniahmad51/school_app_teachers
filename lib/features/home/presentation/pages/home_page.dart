import 'package:flutter/material.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/features/class/presentation/pages/class_page.dart';

import '../widgets/class_card.dart';
import '../widgets/grade_switcher.dart';
import '../widgets/home_colors.dart';
import '../widgets/home_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedGrade = 7;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HomeColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const HomeHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GradeSwitcher(
                        selectedGrade: _selectedGrade,
                        onGradeSelected: (grade) =>
                            setState(() => _selectedGrade = grade),
                      ),
                      const SizedBox(height: 12),
                      ..._classCards,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get _classCards {
    const sections = ['الأولى', 'الثانية', 'الثالثة'];

    return [
      for (var index = 0; index < sections.length; index++)
        Padding(
          padding: EdgeInsets.only(
            bottom: index == sections.length - 1 ? 0 : 8,
          ),
          child: ClassCard(
            title: 'الشعبة ${sections[index]}',
            onPressed: _showClassDetails,
          ),
        ),
    ];
  }

  void _showClassDetails() {
    context.navigationWithFade(const ClassPage());
  }
}
