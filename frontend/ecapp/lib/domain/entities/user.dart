class AuthDetails {
  String accessToken;
  String refreshToken;
  String? message;
  AuthDetails({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });
}
