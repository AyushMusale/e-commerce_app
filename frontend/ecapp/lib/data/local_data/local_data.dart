import 'package:hive/hive.dart';

class AuthDB {
  final Box box = Hive.box('authDB');
  void storeAccessToken(String accessToken) {
    box.put('isLogined', false);
    box.put('access_token', accessToken);
  }

  void storeRefreshToken(String refreshToken) {
    final box = Hive.box('authDB');
    box.put('refresh_token', refreshToken);
  }

  String? getAccessToken() {
    return box.get('access_token');
  }

  String? getRefreshToken() {
    return box.get('refresh_token');
  }

  bool isLoggedIn() {
    return box.get('isLoggedIn', defaultValue: false);
  }

  void logout() {
  box.clear();
}

}
