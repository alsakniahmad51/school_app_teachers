import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';

import '../manager/files_cubit/subject_files_cubit.dart';

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
          onPressed: _pickAndUploadFile,
          backgroundColor: const Color(0xFF007353),
          child: BlocBuilder<SubjectFilesCubit, SubjectFilesState>(
            builder: (context, state) =>
                state is SubjectFilesSuccess && state.isUploading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.add, color: Colors.white),
          ),
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

          final successState = state as SubjectFilesSuccess;
          final files = successState.files;
          if (files.isEmpty) {
            return const Center(child: Text('لا توجد ملفات لهذه المادة'));
          }

          return ListView.separated(
            itemCount: files.length,
            separatorBuilder: (_, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                _fileItem(files[index], index, successState),
          );
        },
      ),
    );
  }

  Future<void> _pickAndUploadFile() async {
    final currentState = context.read<SubjectFilesCubit>().state;
    if (currentState is SubjectFilesSuccess && currentState.isUploading) {
      return;
    }

    final result = await FilePicker.pickFiles();
    if (!mounted || result.isEmpty || result.single.path == null) return;

    final selectedFile = result.single;
    final uploaded = await context.read<SubjectFilesCubit>().uploadFile(
      widget.subjectId,
      selectedFile.path!,
      selectedFile.name,
    );
    if (!mounted || uploaded) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر رفع الملف، حاول مرة أخرى')),
    );
  }

  Widget _fileItem(SubjectFile file, int index, SubjectFilesSuccess state) {
    return AttachmentFileItem(
      title: file.name,
      extension: _extension(file.name),
      isPrimary: false,
      isDownloaded: state.downloadedFileIds.contains(file.id),
      isDownloading: state.downloadingFileIds.contains(file.id),
      isDeleting: state.deletingFileIds.contains(file.id),
      onTap: () => _openFile(file),
      onDelete: () => _deleteFile(file),
    );
  }

  Future<void> _deleteFile(SubjectFile file) async {
    final deleted = await context.read<SubjectFilesCubit>().deleteFile(
      file,
      widget.subjectId,
    );
    if (!mounted || deleted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر حذف الملف، حاول مرة أخرى')),
    );
  }

  Future<void> _openFile(SubjectFile file) async {
    final messenger = ScaffoldMessenger.of(context);

    final filePath = await context.read<SubjectFilesCubit>().downloadFile(file);
    if (!mounted) return;

    messenger.hideCurrentSnackBar();
    if (filePath == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('تعذر تحميل الملف، حاول مرة أخرى')),
      );
      return;
    }

    final result = await OpenFilex.open(filePath);
    if (!mounted || result.type == ResultType.done) return;
    messenger.showSnackBar(SnackBar(content: Text(result.message)));
  }

  String _extension(String fileName) {
    final separatorIndex = fileName.lastIndexOf('.');
    if (separatorIndex == -1 || separatorIndex == fileName.length - 1) {
      return 'FILE';
    }
    return fileName.substring(separatorIndex + 1).toUpperCase();
  }
}
