class LoginRequestModel {
  final String userName;
  final String password;
  final String fcmToken;
  const LoginRequestModel({
    required this.userName,
    required this.password,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    return {'user_name': userName, 'password': password, 'fcm_token': fcmToken};
  }
}
