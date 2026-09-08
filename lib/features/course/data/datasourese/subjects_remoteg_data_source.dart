import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/models/subject_global_model.dart';

abstract class SubjectsRemoteDataSourceGlobal {
  Future<List<SubjectGlobalModel>> getSubjectsByClass(int classId);
}

class SubjectsRemoteDataSourceImplGlobal
    implements SubjectsRemoteDataSourceGlobal {
  final DioConsumer dio;

  SubjectsRemoteDataSourceImplGlobal(this.dio);

  @override
  Future<List<SubjectGlobalModel>> getSubjectsByClass(int classId) async {
    final response = await dio.get("api/dashboard/subjects/class/$classId");

    final List data = response['data'];

    return data.map((subject) => SubjectGlobalModel.fromJson(subject)).toList();
  }
}
