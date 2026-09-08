import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/core/functions/navigation.dart';
import 'package:teachers_app/features/course/data/datasourese/files_remote_data_source.dart';
import 'package:teachers_app/features/course/data/repo/files_repository_impl.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';
import 'package:teachers_app/features/course/domain/usecases/delete_subject_file_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/download_subject_file_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/get_subject_files_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/upload_subject_file_use_case.dart';
import 'package:teachers_app/features/course/presentation/manager/files_cubit/subject_files_cubit.dart';
import 'package:teachers_app/features/course/presentation/pages/course_details_page.dart';

class SubjectListItem extends StatelessWidget {
  final SubjectGlobal subject;
  const SubjectListItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigationWithFade(
          BlocProvider(
            create: (context) => SubjectFilesCubit(
              GetSubjectFilesUseCase(
                FilesRepositoryImpl(
                  FilesRemoteDataSourceImpl(DioConsumer(dio: Dio())),
                ),
              ),
              DownloadSubjectFileUseCase(
                FilesRemoteDataSourceImpl(DioConsumer(dio: Dio())),
              ),
              DeleteSubjectFileUseCase(
                FilesRemoteDataSourceImpl(DioConsumer(dio: Dio())),
              ),
              UploadSubjectFileUseCase(
                FilesRemoteDataSourceImpl(DioConsumer(dio: Dio())),
              ),
            ),
            child: CourseDetailsPage(
              courseTitle: subject.name,
              subjectId: subject.id,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: 372,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.chevron_left_rounded,
                    size: 12,
                    color: Color(0xFF007353),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'عرض المادة',
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF007353),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        subject.name,
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000F0B),
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F7F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.menu_book_rounded,
                        size: 20,
                        color: Color(0xFF007353),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
