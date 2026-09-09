part of 'exams_cubit.dart';

sealed class ExamsState extends Equatable {
  const ExamsState();

  @override
  List<Object?> get props => [];
}

final class ExamsInitial extends ExamsState {}

final class ExamsLoading extends ExamsState {}

final class ExamsSuccess extends ExamsState {
  final List<Exam> exams;

  const ExamsSuccess(this.exams);

  @override
  List<Object?> get props => [exams];
}

final class ExamsFailure extends ExamsState {
  final String message;

  const ExamsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
