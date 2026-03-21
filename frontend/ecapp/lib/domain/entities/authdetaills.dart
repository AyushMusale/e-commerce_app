class AuthDetails {
  String accessToken;
  String refreshToken;
  String? message;
  String? userRole;
  AuthDetails({
    required this.accessToken,
    required this.refreshToken,
    required this.message,
    required this.userRole
  });
}
