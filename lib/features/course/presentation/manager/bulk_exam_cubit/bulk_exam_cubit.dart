import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/course/domain/entity/bulk_exam.dart';
import 'package:teachers_app/features/course/domain/usecases/add_bulk_exam_use_case.dart';

part 'bulk_exam_state.dart';

class BulkExamCubit extends Cubit<BulkExamState> {
  BulkExamCubit(this.addBulkExamUseCase) : super(BulkExamInitial());

  final AddBulkExamUseCase addBulkExamUseCase;

  Future<void> addBulkExam(BulkExam bulkExam) async {
    emit(BulkExamLoading());

    final result = await addBulkExamUseCase(bulkExam);

    result.fold(
      (failure) => emit(BulkExamFailure(failure.message)),
      (message) => emit(BulkExamSuccess(message)),
    );
  }
}
