part of 'subjects_global_cubit.dart';

sealed class SubjectsGlobalState extends Equatable {
  const SubjectsGlobalState();

  @override
  List<Object?> get props => [];
}

final class SubjectsInitial extends SubjectsGlobalState {}

final class SubjectsLoading extends SubjectsGlobalState {}

final class SubjectsSuccess extends SubjectsGlobalState {
  final List<SubjectGlobal> subjects;

  const SubjectsSuccess(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

final class SubjectsFailure extends SubjectsGlobalState {
  final String message;

  const SubjectsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
