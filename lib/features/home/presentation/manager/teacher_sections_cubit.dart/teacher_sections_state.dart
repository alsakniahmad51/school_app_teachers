part of 'teacher_sections_cubit.dart';

sealed class TeacherSectionsState extends Equatable {
  const TeacherSectionsState();

  @override
  List<Object?> get props => [];
}

final class TeacherSectionsInitial extends TeacherSectionsState {}

final class TeacherSectionsLoading extends TeacherSectionsState {}

final class TeacherSectionsSuccess extends TeacherSectionsState {
  final TeacherSections data;

  const TeacherSectionsSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

final class TeacherSectionsFailure extends TeacherSectionsState {
  final String message;

  const TeacherSectionsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
