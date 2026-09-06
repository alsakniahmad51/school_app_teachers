import 'package:dio/dio.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure implements Exception {
  ServerFailure(super.message);
}

ServerFailure handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return ServerFailure(
        'انتهت مهلة الاتصال بالخادم. الرجاء المحاولة لاحقًا.',
      );
    case DioExceptionType.sendTimeout:
      return ServerFailure(
        'انتهت مهلة إرسال البيانات. تأكد من اتصالك بالإنترنت.',
      );
    case DioExceptionType.receiveTimeout:
      return ServerFailure(
        'انتهت مهلة استلام البيانات. يرجى التحقق من الشبكة.',
      );
    case DioExceptionType.badCertificate:
      return ServerFailure(
        'الشهادة الأمنية غير صالحة. لا يمكن التحقق من الخادم.',
      );
    case DioExceptionType.cancel:
      return ServerFailure('تم إلغاء الطلب قبل إرساله.');
    case DioExceptionType.connectionError:
      return ServerFailure('حدث خطأ في الاتصال بالخادم. تحقق من الإنترنت.');
    case DioExceptionType.unknown:
      return ServerFailure('حدث خطأ غير متوقع. يرجى المحاولة لاحقًا.');
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          final msg = e.response?.data is Map<String, dynamic>
              ? e.response?.data['message'] ?? 'الطلب غير صالح.'
              : 'الطلب غير صالح.';
          return ServerFailure(msg);
        case 401:
          return ServerFailure('غير مصرح. تأكد من تسجيل الدخول.');
        case 403:
          return ServerFailure('ليس لديك صلاحية للوصول إلى هذا المورد.');
        case 404:
          return ServerFailure('العنصر المطلوب غير موجود.');
        case 409:
          return ServerFailure('يوجد تعارض في البيانات المدخلة.');
        case 422:
          return ServerFailure(
            'لا يمكن معالجة البيانات المدخلة. تحقق من صحتها.',
          );
        case 500:
          return ServerFailure('غير مصرح. تأكد من تسجيل الدخول.');
        case 503:
          return ServerFailure(
            'الخدمة غير متوفرة حاليًا. الرجاء المحاولة لاحقًا.',
          );
        case 504:
          return ServerFailure('الخادم لم يستجب في الوقت المحدد.');
        default:
          return ServerFailure(
            'حدث خطأ في الخادم. [${e.response?.statusCode}]',
          );
      }
    case DioExceptionType.transformTimeout:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}
