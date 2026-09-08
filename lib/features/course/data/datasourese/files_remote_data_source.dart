import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teachers_app/core/api/dio_consumer.dart';
import 'package:teachers_app/features/course/data/models/subject_file_model.dart';

abstract class FilesRemoteDataSource {
  Future<List<SubjectFileModel>> getSubjectFiles(int subjectId);
  Future<void> uploadFile(int subjectId, String filePath, String fileName);
  Future<String> downloadFile(int fileId, String fileName);
  Future<bool> isFileDownloaded(int fileId, String fileName);
  Future<void> deleteFile(int fileId, String fileName);
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

  @override
  Future<void> uploadFile(
    int subjectId,
    String filePath,
    String fileName,
  ) async {
    final formData = FormData.fromMap({
      'name': fileName,
      'subject_id': subjectId.toString(),
      'file_path': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    await dio.dio.post('api/dashboard/files', data: formData);
  }

  @override
  Future<String> downloadFile(int fileId, String fileName) async {
    final filePath = await _filePath(fileId, fileName);
    final localFile = File(filePath);
    if (await localFile.exists()) return filePath;

    await dio.dio.download(
      'api/dashboard/files/$fileId/download',
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );

    return filePath;
  }

  @override
  Future<bool> isFileDownloaded(int fileId, String fileName) async {
    return File(await _filePath(fileId, fileName)).exists();
  }

  @override
  Future<void> deleteFile(int fileId, String fileName) async {
    await dio.delete('api/dashboard/files/$fileId');
    final localFile = File(await _filePath(fileId, fileName));
    if (await localFile.exists()) {
      await localFile.delete();
    }
  }

  Future<String> _filePath(int fileId, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final safeFileName = fileName.split('/').last;
    return '${directory.path}/${fileId}_$safeFileName';
  }
}
