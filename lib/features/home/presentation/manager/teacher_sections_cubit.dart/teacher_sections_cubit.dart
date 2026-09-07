import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teachers_app/features/home/domain/entity/teacher_sections.dart';
import 'package:teachers_app/features/home/domain/usecases/get_teacher_sections_use_case.dart';

part 'teacher_sections_state.dart';

class TeacherSectionsCubit extends Cubit<TeacherSectionsState> {
  TeacherSectionsCubit(this.getTeacherSectionsUseCase)
    : super(TeacherSectionsInitial());
  final GetTeacherSectionsUseCase getTeacherSectionsUseCase;

  Future<void> getTeacherSections() async {
    emit(TeacherSectionsLoading());

    final result = await getTeacherSectionsUseCase();
    result.fold(
      (failure) => emit(TeacherSectionsFailure(failure.message)),
      (data) => emit(TeacherSectionsSuccess(data)),
    );
  }
}
