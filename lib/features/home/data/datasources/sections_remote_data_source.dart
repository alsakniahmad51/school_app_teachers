import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/home/data/models/teacher_sections_model.dart';

import 'package:teachers_app/features/home/data/models/teacher_sections_model.dart';

abstract class SectionsRemoteDataSource {
  Future<TeacherSectionsModel> getTeacherSections();
}

class SectionsRemoteDataSourceImpl implements SectionsRemoteDataSource {
  final DioConsumer dio;

  SectionsRemoteDataSourceImpl(this.dio);

  @override
  Future<TeacherSectionsModel> getTeacherSections() async {
    final response = await dio.get("api/dashboard/teacher/my-sections");
    return TeacherSectionsModel.fromJson(response);
  }
}
