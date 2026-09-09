import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/datasourese/exams_remote_data_source.dart';
import 'package:teachers_app/features/course/data/repo/exams_repository_impl.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';
import 'package:teachers_app/features/course/domain/usecases/add_bulk_exam_use_case.dart';
import '../manager/bulk_exam_cubit/bulk_exam_cubit.dart';

import '../manager/exam_cubit/exams_cubit.dart';
import 'test_details_page.dart';
import '../widgets/course_test_card.dart';

class CourseTestsPage extends StatefulWidget {
  const CourseTestsPage({
    super.key,
    required this.subjectId,
    required this.courseTitle,
  });

  final int subjectId;
  final String courseTitle;

  @override
  State<CourseTestsPage> createState() => _CourseTestsPageState();
}

class _CourseTestsPageState extends State<CourseTestsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExamsCubit>().getExamsList(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsState>(
      builder: (context, state) {
        if (state is ExamsInitial || state is ExamsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExamsFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message),
                TextButton(
                  onPressed: () =>
                      context.read<ExamsCubit>().getExamsList(widget.subjectId),
                  child: const Text('إعادة المحاولة'),
                ),
              ],
            ),
          );
        }

        final exams = (state as ExamsSuccess).exams;
        if (exams.isEmpty) {
          return const Center(child: Text('لا توجد اختبارات لهذه المادة'));
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: exams.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) => _examCard(exams[index]),
        );
      },
    );
  }

  Widget _examCard(Exam exam) {
    return CourseTestCard(
      test: exam,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => BulkExamCubit(
                AddBulkExamUseCase(
                  ExamsRepositoryImpl(
                    ExamsRemoteDataSourceImpl(DioConsumer(dio: Dio())),
                  ),
                ),
              ),
              child: TestDetailsPage(
                courseTitle: widget.courseTitle,
                testTitle: exam.examType,
                subjectId: widget.subjectId,
                examDate: exam.date,
                initialStudents: const [],
              ),
            ),
          ),
        );
      },
    );
  }
}
