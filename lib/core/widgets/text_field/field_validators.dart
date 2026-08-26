enum FieldType {
  email,
  password,
  search,
  fName,
  lName,
  phoneNumber,
  academicYear,
  day,
  month,
  year,
  activationCode,
}

Map<FieldType, String?> remoteErrors = {};

String? validateField(
    FieldType type, String? value, dynamic extraValidationData) {
  if (remoteErrors[type] != null) {
    return remoteErrors[type];
  }

  final unsafeRegex = RegExp(
    r'''[<>;"'`]|--|\bor\b|\band\b''',
    caseSensitive: false,
  );

  if (value != null && value.isNotEmpty && type != FieldType.email) {
    if (unsafeRegex.hasMatch(value)) {
      return "النص يحتوي على رموز غير مسموحة";
    }
  }

  switch (type) {
    case FieldType.email:
      if (value == null || value.trim().isEmpty) {
        return 'البريد الإلكتروني مطلوب';
      }

      final v = value.trim().toLowerCase();

      if (!v.endsWith('@gmail.com')) {
        return 'صيغة البريد الإلكتروني غير صحيحة';
      }

      final emailRegex = RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$");

      if (!emailRegex.hasMatch(v)) {
        return 'صيغة البريد الإلكتروني غير صحيحة';
      }
      break;

    case FieldType.password:
      if (value == null || value.isEmpty) return 'كلمة المرور مطلوبة';
      if (value.length < 8) return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
      break;

    case FieldType.search:
      if (value == null || value.isEmpty) return 'يرجى كتابة كلمة للبحث';
      break;

    case FieldType.fName:
      if (value == null || value.trim().isEmpty) {
        return 'أدخل اسمك الأول، هذا الحقل مطلوب';
      }
      if (value.trim().length < 2) {
        return 'الاسم يجب أن يكون على الأقل حرفين';
      }

      final input = value.trim();

      final englishRegex = RegExp(r'[a-zA-Z]');
      if (englishRegex.hasMatch(input)) {
        return 'الاسم حصراً باللغة العربية';
      }

      final arabicRegex = RegExp(r'^[ء-ي\s]+$');
      if (!arabicRegex.hasMatch(input)) {
        return 'الاسم يحتوي على رموز غير مسموحة';
      }

      break;

    case FieldType.phoneNumber:
      final countryCode = extraValidationData;

      if (value == null || value.trim().isEmpty) {
        return 'رقم الهاتف مطلوب';
      }

      final trimmed = value.trim();

      if (countryCode == "+963") {
        if (!trimmed.startsWith('9')) {
          return 'الرقم غير صالح، يجب أن يبدأ ب 9';
        }
        if (trimmed.length != 9) {
          return 'يجب أن يتكون من 9 أرقام';
        }
        return null;
      }

      final globalRegex = RegExp(r'^[0-9]{6,15}$');

      if (!globalRegex.hasMatch(trimmed)) {
        return 'يجب أن يكون بين 6 و 15 رقماً';
      }

      break;

    case FieldType.academicYear:
      if (value == null || value.trim().isEmpty) {
        return "الحقل مطلوب";
      }
      if (value.trim().length > 10) {
        return "الرقم خاطئ";
      }
      if (RegExp(r'^0+$').hasMatch(value.trim())) {
        return "الرقم خاطئ";
      }
      break;

    case FieldType.day:
      if (value == null || value.trim().isEmpty) return "أدخل اليوم";
      final day = int.tryParse(value.trim());
      if (day == null || day <= 0 || day > 31) return "قيمة خاطئة";
      break;

    case FieldType.month:
      if (value == null || value.trim().isEmpty) return "أدخل الشهر";
      final month = int.tryParse(value.trim());
      if (month == null || month <= 0 || month > 12) return "قيمة خاطئة";
      break;

    case FieldType.year:
      if (value == null || value.trim().isEmpty) return "أدخل السنة";
      final year = int.tryParse(value.trim());
      if (year == null || year < 1900 || year > DateTime.now().year - 15) {
        return "قيمة خاطئة";
      }
      break;

    case FieldType.activationCode:
      final codeRegex = RegExp(r'^[a-zA-Z0-9]+$');

      if (value == null || value.isEmpty) {
        return "الرجاء إدخال رمز التفعيل.";
      }

      if (!codeRegex.hasMatch(value)) {
        return "رمز غير صالح،يجب أن يحوي فقط أحرف وأرقام إنكليزية.";
      }

      return null;
    case FieldType.lName:
      if (value == null || value.trim().isEmpty) {
        return 'أدخل اسمك الأخير، هذا الحقل مطلوب';
      }
      if (value.trim().length < 2) {
        return 'الاسم يجب أن يكون على الأقل حرفين';
      }

      final input = value.trim();

      // إذا كتب إنكليزي
      final englishRegex = RegExp(r'[a-zA-Z]');
      if (englishRegex.hasMatch(input)) {
        return 'الاسم حصراً باللغة العربية';
      }

      // إذا كتب أي رمز غير مسموح
      final arabicRegex = RegExp(r'^[ء-ي\s]+$');
      if (!arabicRegex.hasMatch(input)) {
        return 'الاسم يحتوي على رموز غير مسموحة';
      }

      break;
  }

  return null;
}
