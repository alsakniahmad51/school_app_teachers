import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/class/presentation/manager/subjects_cubit.dart';
import 'package:teachers_app/features/class/presentation/widgets/class_header.dart';
import 'package:teachers_app/features/home/domain/entity/section.dart';

import '../widgets/subject_list_item.dart';

class ClassPage extends StatelessWidget {
  final Section section;
  const ClassPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    context.read<SubjectsCubit>().getSubjects(section.classId, section.id);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ClassHeader(section: section),
              const SizedBox(height: 12),
              BlocBuilder<SubjectsCubit, SubjectsState>(
                builder: (context, state) {
                  if (state is SubjectsLoading) {
                    return Expanded(
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is SubjectsFailure) {
                    return Center(child: Text(state.message));
                  } else if (state is SubjectsSuccess) {
                    final subjects = state.subjects;
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          return SubjectListItem(subject: subjects[index]);
                        },
                      ),
                    );
                  }
                  return Center(child: Text("حدث خطأ ما أثناء تحميل المواد"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
