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
  final Set<int> downloadedFileIds;
  final Set<int> downloadingFileIds;
  final Set<int> deletingFileIds;
  final bool isUploading;

  const SubjectFilesSuccess(
    this.files, {
    this.downloadedFileIds = const {},
    this.downloadingFileIds = const {},
    this.deletingFileIds = const {},
    this.isUploading = false,
  });

  SubjectFilesSuccess copyWith({
    Set<int>? downloadedFileIds,
    Set<int>? downloadingFileIds,
    Set<int>? deletingFileIds,
    bool? isUploading,
  }) {
    return SubjectFilesSuccess(
      files,
      downloadedFileIds: downloadedFileIds ?? this.downloadedFileIds,
      downloadingFileIds: downloadingFileIds ?? this.downloadingFileIds,
      deletingFileIds: deletingFileIds ?? this.deletingFileIds,
      isUploading: isUploading ?? this.isUploading,
    );
  }

  @override
  List<Object?> get props => [
    files,
    downloadedFileIds,
    downloadingFileIds,
    deletingFileIds,
    isUploading,
  ];
}

final class SubjectFilesFailure extends SubjectFilesState {
  final String message;

  const SubjectFilesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
