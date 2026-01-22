import 'dart:convert';
import 'package:ecapp/data/models/registermodel.dart';
import 'package:http/http.dart' as http;

class Registerrepo {
  final http.Client client;
  Registerrepo({http.Client? client}) : client = client ?? http.Client();

  Future<Registermodel> execute({
    required String email,
    required String password,
    required String confirmpassword,
    required String selectedrole,
  }) async {
    final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/signup");

    final res = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "user_role": selectedrole,
      }),
    );
    final jsonRes = jsonDecode(res.body);

    if (res.statusCode == 200 || res.statusCode == 201) {
      return Registermodel(message: jsonRes['message']);
    } else {
      throw Exception(jsonRes['message']);
    }
  }
}
