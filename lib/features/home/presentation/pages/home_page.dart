import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/features/class/data/datasource/subjects_remote_data_source.dart';
import 'package:teachers_app/features/class/data/repo/subjects_repository_impl.dart';
import 'package:teachers_app/features/class/domain/usecase/get_subjects_by_class_and_section_use_case.dart';
import 'package:teachers_app/features/class/presentation/manager/subjects_cubit.dart';
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
  String _selectedGrade = "الصف السابع";
  @override
  void initState() {
    super.initState();

    context.read<TeacherSectionsCubit>().getTeacherSections();
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
                return const Center(child: CircularProgressIndicator());
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
                return Center(
                  child: Column(
                    children: [
                      Text('حدث خطأ أثناء تحميل البيانات'),
                      TextButton(
                        onPressed: () {
                          context
                              .read<TeacherSectionsCubit>()
                              .getTeacherSections();
                        },
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }
              return Column(
                children: [
                  const Center(child: Text('حدث خطأ غير معروف')),
                  TextButton(
                    onPressed: () {
                      context.read<TeacherSectionsCubit>().getTeacherSections();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _classCards({required TeacherSections teachersections}) {
    List<Section> sections = teachersections.sections
        .where((section) => section.className == _selectedGrade)
        .toList();
    return [
      for (var index = 0; index < sections.length; index++)
        Padding(
          padding: EdgeInsets.only(
            bottom: index == sections.length - 1 ? 0 : 8,
          ),
          child: ClassCard(
            title: sections[index].name,
            onPressed: () => _showClassDetails(sections[index]),
            totalStudents: sections[index].totalStudents,
          ),
        ),
    ];
  }

  void _showClassDetails(Section section) {
    context.navigationWithFade(
      BlocProvider(
        create: (context) => SubjectsCubit(
          GetSubjectsByClassAndSectionUseCase(
            SubjectsRepositoryImpl(
              SubjectsRemoteDataSourceImpl(DioConsumer(dio: Dio())),
            ),
          ),
        ),
        child: ClassPage(section: section),
      ),
    );
  }
}
