import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

import '../manager/subject_files_cubit.dart';

import '../widgets/attachment_file_item.dart';

class CourseAttachmentsPage extends StatefulWidget {
  const CourseAttachmentsPage({super.key, required this.subjectId});

  final int subjectId;

  @override
  State<CourseAttachmentsPage> createState() => _CourseAttachmentsPageState();
}

class _CourseAttachmentsPageState extends State<CourseAttachmentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectFilesCubit>().getSubjectFiles(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: const Color(0xFF007353),
        ),
      ),
      body: BlocBuilder<SubjectFilesCubit, SubjectFilesState>(
        builder: (context, state) {
          if (state is SubjectFilesLoading || state is SubjectFilesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SubjectFilesFailure) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  TextButton(
                    onPressed: () => context
                        .read<SubjectFilesCubit>()
                        .getSubjectFiles(widget.subjectId),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }

          final files = (state as SubjectFilesSuccess).files;
          if (files.isEmpty) {
            return const Center(child: Text('لا توجد ملفات لهذه المادة'));
          }

          return ListView.separated(
            itemCount: files.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => _fileItem(files[index], index),
          );
        },
      ),
    );
  }

  Widget _fileItem(SubjectFile file, int index) {
    return AttachmentFileItem(
      title: file.name,
      extension: _extension(file.name),
      isPrimary: index == 0,
    );
  }

  String _extension(String fileName) {
    final separatorIndex = fileName.lastIndexOf('.');
    if (separatorIndex == -1 || separatorIndex == fileName.length - 1) {
      return 'FILE';
    }
    return fileName.substring(separatorIndex + 1).toUpperCase();
  }
}
