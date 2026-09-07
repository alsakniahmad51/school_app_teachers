import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/core/manager/fcm_cubit/fcm_cubit.dart';
import 'package:teachers_app/features/class/presentation/pages/class_page.dart';
import 'package:teachers_app/features/home/domain/entity/section.dart';
import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';
import 'package:teachers_app/features/home/presentation/manager/teacher_sections_cubit.dart/teacher_sections_cubit.dart';

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
  void initState() {
    super.initState();
    _initFcm();
    context.read<TeacherSectionsCubit>().getTeacherSections();
  }

  Future<void> _initFcm() async {
    final fcmCubit = context.read<FcmCubit>();

    await fcmCubit.init(true, null);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: HomeColors.background,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<TeacherSectionsCubit, TeacherSectionsState>(
            builder: (context, state) {
              if (state is TeacherSectionsLoading) {
                return Expanded(
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is TeacherSectionsSuccess) {
                return Column(
                  children: [
                    HomeHeader(teacherName: state.data.teacherName),
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
                            ..._classCards(teachersections: state.data),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is TeacherSectionsFailure) {
                return const Center(
                  child: Text('حدث خطأ أثناء تحميل البيانات'),
                );
              }
              return const Center(child: Text('حدث خطأ غير معروف'));
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _classCards({required TeacherSections teachersections}) {
    List<Section> sections = teachersections.sections;
    return [
      for (var index = 0; index < sections.length; index++)
        Padding(
          padding: EdgeInsets.only(
            bottom: index == sections.length - 1 ? 0 : 8,
          ),
          child: ClassCard(
            title: sections[index].name,
            onPressed: () => _showClassDetails(sections[index]),
          ),
        ),
    ];
  }

  void _showClassDetails(Section section) {
    context.navigationWithFade(ClassPage(section: section));
  }
}
