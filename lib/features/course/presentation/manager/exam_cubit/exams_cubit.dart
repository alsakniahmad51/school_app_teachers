import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/course/domain/entity/exam.dart';
import 'package:teachers_app/features/course/domain/usecases/get_exams_list_use_case.dart';

part 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {
  ExamsCubit(this.getExamsListUseCase) : super(ExamsInitial());

  final GetExamsListUseCase getExamsListUseCase;

  Future<void> getExamsList(int subjectId) async {
    emit(ExamsLoading());

    final result = await getExamsListUseCase(subjectId);

    result.fold(
      (failure) => emit(ExamsFailure(failure.message)),
      (exams) => emit(ExamsSuccess(exams)),
    );
  }
}
