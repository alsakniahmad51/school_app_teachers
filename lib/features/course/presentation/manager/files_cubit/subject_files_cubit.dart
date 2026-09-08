import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';
import 'package:teachers_app/features/course/domain/usecases/delete_subject_file_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/download_subject_file_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/get_subject_files_use_case.dart';
import 'package:teachers_app/features/course/domain/usecases/upload_subject_file_use_case.dart';

part 'subject_files_state.dart';

class SubjectFilesCubit extends Cubit<SubjectFilesState> {
  SubjectFilesCubit(
    this.getSubjectFilesUseCase,
    this.downloadSubjectFileUseCase,
    this.deleteSubjectFileUseCase,
    this.uploadSubjectFileUseCase,
  ) : super(SubjectFilesInitial());
  final GetSubjectFilesUseCase getSubjectFilesUseCase;
  final DownloadSubjectFileUseCase downloadSubjectFileUseCase;
  final DeleteSubjectFileUseCase deleteSubjectFileUseCase;
  final UploadSubjectFileUseCase uploadSubjectFileUseCase;

  Future<bool> uploadFile(
    int subjectId,
    String filePath,
    String fileName,
  ) async {
    final currentState = state;
    if (currentState is! SubjectFilesSuccess || currentState.isUploading) {
      return false;
    }

    emit(currentState.copyWith(isUploading: true));
    final result = await uploadSubjectFileUseCase(
      subjectId,
      filePath,
      fileName,
    );
    return result.fold(
      (_) {
        if (!isClosed && state is SubjectFilesSuccess) {
          emit((state as SubjectFilesSuccess).copyWith(isUploading: false));
        }
        return false;
      },
      (_) {
        getSubjectFiles(subjectId);
        return true;
      },
    );
  }

  Future<bool> deleteFile(SubjectFile file, int subjectId) async {
    final currentState = state;
    if (currentState is! SubjectFilesSuccess ||
        currentState.deletingFileIds.contains(file.id)) {
      return false;
    }

    emit(
      currentState.copyWith(
        deletingFileIds: {...currentState.deletingFileIds, file.id},
      ),
    );

    final result = await deleteSubjectFileUseCase(file);
    return result.fold(
      (_) {
        if (!isClosed && state is SubjectFilesSuccess) {
          final updatedState = state as SubjectFilesSuccess;
          emit(
            updatedState.copyWith(
              deletingFileIds: {...updatedState.deletingFileIds}
                ..remove(file.id),
            ),
          );
        }
        return false;
      },
      (_) {
        getSubjectFiles(subjectId);
        return true;
      },
    );
  }

  Future<String?> downloadFile(SubjectFile file) async {
    final currentState = state;
    if (currentState is SubjectFilesSuccess) {
      emit(
        currentState.copyWith(
          downloadingFileIds: {...currentState.downloadingFileIds, file.id},
        ),
      );
    }

    final result = await downloadSubjectFileUseCase(file.id, file.name);
    if (state is! SubjectFilesSuccess)
      return result.fold((_) => null, (path) => path);

    final updatedState = state as SubjectFilesSuccess;
    return result.fold(
      (_) {
        emit(
          updatedState.copyWith(
            downloadingFileIds: {...updatedState.downloadingFileIds}
              ..remove(file.id),
          ),
        );
        return null;
      },
      (filePath) {
        emit(
          updatedState.copyWith(
            downloadedFileIds: {...updatedState.downloadedFileIds, file.id},
            downloadingFileIds: {...updatedState.downloadingFileIds}
              ..remove(file.id),
          ),
        );
        return filePath;
      },
    );
  }

  Future<void> getSubjectFiles(int subjectId) async {
    emit(SubjectFilesLoading());

    final result = await getSubjectFilesUseCase(subjectId);
    result.fold((failure) => emit(SubjectFilesFailure(failure.message)), (
      files,
    ) async {
      final downloadedFileIds = <int>{};
      for (final file in files) {
        if (await downloadSubjectFileUseCase.isDownloaded(file)) {
          downloadedFileIds.add(file.id);
        }
      }
      if (!isClosed) {
        emit(SubjectFilesSuccess(files, downloadedFileIds: downloadedFileIds));
      }
    });
  }
}
