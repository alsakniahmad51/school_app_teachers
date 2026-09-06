class AuthUser {
  final String id;
  final String message;
  final String accessToken;

  const AuthUser({
    required this.message,
    required this.accessToken,
    required this.id,
  });
}
