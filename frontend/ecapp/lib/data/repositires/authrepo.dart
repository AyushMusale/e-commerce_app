import 'dart:convert';
import '../local_data/local_data.dart';
import 'package:ecapp/domain/entities/user.dart';
import 'package:ecapp/domain/repositries/authrepointf.dart';
import 'package:http/http.dart' as http;

class Authrepo extends Authrepointf {
  AuthDB authDB;
  Authrepo(this.authDB);

  Future<AuthDetails> execute({required String email, required String password}) async {
    Uri url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/login");
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
      authDB.store(jsonRes['token']);
      return AuthDetails(token: jsonRes['token'], message: 'success');
    }
    else{
      throw Exception(jsonRes['message'] ?? 'login-failed');
    }
  }
}
