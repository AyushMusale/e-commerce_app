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
    final jsonRes = jsonDecode(res.body);
    if (res.statusCode == 200) {
      authDB.storeAccessToken(jsonRes['access_token']);
      authDB.storeRefreshToken(jsonRes['refresh_token']);
      return true;
    }
    if (res.statusCode == 401) {
      throw RefreshTokenExpiredException();
    }
    return false;
  }
}
