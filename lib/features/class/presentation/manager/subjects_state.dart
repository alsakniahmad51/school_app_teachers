part of 'subjects_cubit.dart';

sealed class SubjectsState extends Equatable {
  const SubjectsState();

  @override
  List<Object?> get props => [];
}

final class SubjectsInitial extends SubjectsState {}

final class SubjectsLoading extends SubjectsState {}

final class SubjectsSuccess extends SubjectsState {
  final List<Subject> subjects;

  const SubjectsSuccess(this.subjects);

  @override
  List<Object?> get props => [subjects];
}

final class SubjectsFailure extends SubjectsState {
  final String message;

  const SubjectsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
