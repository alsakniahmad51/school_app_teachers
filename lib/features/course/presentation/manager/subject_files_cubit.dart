import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/course/domain/entity/subject_file.dart';
import 'package:teachers_app/features/course/domain/usecases/get_subject_files_use_case.dart';

part 'subject_files_state.dart';

class SubjectFilesCubit extends Cubit<SubjectFilesState> {
  SubjectFilesCubit(this.getSubjectFilesUseCase) : super(SubjectFilesInitial());
  final GetSubjectFilesUseCase getSubjectFilesUseCase;

  Future<void> getSubjectFiles(int subjectId) async {
    emit(SubjectFilesLoading());

    final result = await getSubjectFilesUseCase(subjectId);
    result.fold(
      (failure) => emit(SubjectFilesFailure(failure.message)),
      (files) => emit(SubjectFilesSuccess(files)),
    );
  }
}
