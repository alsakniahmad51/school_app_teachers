import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/course/domain/entity/subject_global.dart';
import 'package:teachers_app/features/course/domain/usecases/get_subjects_by_class_use_case_global.dart';

part 'subjects_global_state.dart';

class SubjectsCubitGlobal extends Cubit<SubjectsGlobalState> {
  SubjectsCubitGlobal(this.getSubjectsByClassUseCase)
    : super(SubjectsInitial());

  final GetSubjectsByClassUseCaseGlobal getSubjectsByClassUseCase;

  Future<void> getSubjectsByClass(int classId) async {
    emit(SubjectsLoading());

    final result = await getSubjectsByClassUseCase(classId);

    result.fold(
      (failure) => emit(SubjectsFailure(failure.message)),
      (subjects) => emit(SubjectsSuccess(subjects)),
    );
  }
}
