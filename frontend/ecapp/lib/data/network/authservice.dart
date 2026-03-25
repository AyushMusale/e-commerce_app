import 'dart:convert';

import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/local_data/local_data.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final AuthDB authDB;

  AuthService(this.authDB);

  String? get accessToken => authDB.getAccessToken();
  String? get refreshToken => authDB.getRefreshToken();

  Future<bool> refreshTokenRequest() async {
    final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/auth/token");
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'access_token': accessToken,
        'refresh_token': refreshToken,
      }),
    );
    print(res.statusCode);
    final jsonRes = jsonDecode(res.body);
    if (res.statusCode == 200) {
      authDB.storeAccessToken(jsonRes['access_token']);
      authDB.storeRefreshToken(jsonRes['refresh_token']);
      print("NEW TOKEN STORED: ${jsonRes['refresh_token']}");
      print("TOKEN AFTER STORE: ${authDB.getRefreshToken()}");
      return true;
    }
    if (res.statusCode == 401) {
      print(jsonRes['message']);
      throw RefreshTokenExpiredException();
    }
    return false;
  }
}
