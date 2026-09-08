import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/class/domain/entity/subject.dart';
import 'package:teachers_app/features/class/domain/usecase/get_subjects_by_class_and_section_use_case.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit(this.getSubjectsByClassAndSectionUseCase)
    : super(SubjectsInitial());
  final GetSubjectsByClassAndSectionUseCase getSubjectsByClassAndSectionUseCase;

  Future<void> getSubjects(int classId, int sectionId) async {
    emit(SubjectsLoading());

    final result = await getSubjectsByClassAndSectionUseCase(
      classId,
      sectionId,
    );
    result.fold(
      (failure) => emit(SubjectsFailure(failure.message)),
      (subjects) => emit(SubjectsSuccess(subjects)),
    );
  }
}
