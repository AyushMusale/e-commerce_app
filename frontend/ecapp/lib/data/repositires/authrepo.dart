import 'dart:convert';
import '../local_data/local_data.dart';
import 'package:ecapp/domain/entities/authdetaills.dart';
import 'package:ecapp/domain/repositries/authrepointf.dart';
import 'package:http/http.dart' as http;

class Authrepo extends Authrepointf {
  AuthDB authDB;
  Authrepo(this.authDB);

  @override
  Future<AuthDetails> execute({required String email, required String password}) async {
    Uri url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/auth/login");
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      })
    );
    final jsonRes = jsonDecode(res.body);
    if(res.statusCode==200 || res.statusCode==201){
      authDB.storeAccessToken(jsonRes['access_token']);
      authDB.storeRefreshToken(jsonRes['refresh_token']);
      authDB.storeUserrole(jsonRes['user']['user_role']);
      return AuthDetails(accessToken: jsonRes['access_token'], refreshToken: jsonRes["refresh_token"],message: 'success', userRole: jsonRes['user']['user_role']);
    }
    else{
      throw Exception(jsonRes['message'] ?? 'login-failed');
    }
  }
}
