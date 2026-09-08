import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/class/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectModel>> getSubjectsByClassAndSection(
    int classId,
    int sectionId,
  );
}

class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  final DioConsumer dio;

  SubjectsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SubjectModel>> getSubjectsByClassAndSection(
    int classId,
    int sectionId,
  ) async {
    final response = await dio.get(
      "api/dashboard/subjects/class/$classId/section/$sectionId",
    );
    final data = response['data'] as List;
    return data.map((e) => SubjectModel.fromJson(e)).toList();
  }
}
