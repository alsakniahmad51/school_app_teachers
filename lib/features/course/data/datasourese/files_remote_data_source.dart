import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/models/subject_file_model.dart';

abstract class FilesRemoteDataSource {
  Future<List<SubjectFileModel>> getSubjectFiles(int subjectId);
}

class FilesRemoteDataSourceImpl implements FilesRemoteDataSource {
  final DioConsumer dio;

  FilesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SubjectFileModel>> getSubjectFiles(int subjectId) async {
    final response = await dio.get("api/dashboard/files/subject/$subjectId");
    final files = response['data']['files'] as List;
    return files.map((e) => SubjectFileModel.fromJson(e)).toList();
  }
}
