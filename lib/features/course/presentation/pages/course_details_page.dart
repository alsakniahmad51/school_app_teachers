import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/datasourese/exams_remote_data_source.dart';
import 'package:teachers_app/features/course/data/repo/exams_repository_impl.dart';
import 'package:teachers_app/features/course/domain/usecases/get_exams_list_use_case.dart';

import 'course_attachments_page.dart';
import 'course_test_page.dart';
import '../manager/exam_cubit/exams_cubit.dart';
import '../widgets/course_details_header.dart';
import '../widgets/course_tab_switcher.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({
    super.key,
    required this.courseTitle,
    required this.subjectId,
  });

  final String courseTitle;
  final int subjectId;

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  bool showAttachments = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 412),
              child: Container(
                width: 412,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: const BoxDecoration(color: Color(0xFFF7F7F7)),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    CourseDetailsHeader(courseTitle: widget.courseTitle),
                    const SizedBox(height: 18),
                    CourseTabSwitcher(
                      showAttachments: showAttachments,
                      onTabChanged: (value) =>
                          setState(() => showAttachments = value),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: showAttachments
                          ? CourseAttachmentsPage(subjectId: widget.subjectId)
                          : BlocProvider(
                              create: (_) => ExamsCubit(
                                GetExamsListUseCase(
                                  ExamsRepositoryImpl(
                                    ExamsRemoteDataSourceImpl(
                                      DioConsumer(dio: Dio()),
                                    ),
                                  ),
                                ),
                              ),
                              child: CourseTestsPage(
                                subjectId: widget.subjectId,
                                courseTitle: widget.courseTitle,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
