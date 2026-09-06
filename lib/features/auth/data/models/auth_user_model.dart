import 'package:teachers_app/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.message,
    required super.accessToken,
    required super.id,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
