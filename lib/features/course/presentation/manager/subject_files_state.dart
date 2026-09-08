part of 'subject_files_cubit.dart';

sealed class SubjectFilesState extends Equatable {
  const SubjectFilesState();

  @override
  List<Object?> get props => [];
}

final class SubjectFilesInitial extends SubjectFilesState {}

final class SubjectFilesLoading extends SubjectFilesState {}

final class SubjectFilesSuccess extends SubjectFilesState {
  final List<SubjectFile> files;

  const SubjectFilesSuccess(this.files);

  @override
  List<Object?> get props => [files];
}

final class SubjectFilesFailure extends SubjectFilesState {
  final String message;

  const SubjectFilesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
