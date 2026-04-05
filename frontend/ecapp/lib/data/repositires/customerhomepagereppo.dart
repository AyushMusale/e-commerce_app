import 'dart:convert';

import 'package:ecapp/data/models/homedata.dart';
import 'package:ecapp/data/network/authclient.dart';

class GetCustomerHomepageDataRepo {
  AuthClient client;
  GetCustomerHomepageDataRepo({required this.client});

  Future<Homedata> execute() async {
    try {
      {
        final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/customer/home");
        var res = await client.get(url);
        if (res.statusCode == 200) {
          Homedata homedata = Homedata.fromJson(jsonDecode(res.body));
          return homedata;
        }
        else{
          throw Exception("Something went wrong");
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
