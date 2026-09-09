part of 'bulk_exam_cubit.dart';

sealed class BulkExamState extends Equatable {
  const BulkExamState();

  @override
  List<Object?> get props => [];
}

final class BulkExamInitial extends BulkExamState {}

final class BulkExamLoading extends BulkExamState {}

final class BulkExamSuccess extends BulkExamState {
  final String message;

  const BulkExamSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class BulkExamFailure extends BulkExamState {
  final String message;

  const BulkExamFailure(this.message);

  @override
  List<Object?> get props => [message];
}
