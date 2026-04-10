import 'dart:convert';

import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/searchlist.dart';
import 'package:ecapp/data/network/authclient.dart';

class SearchRepo {
  AuthClient client;
  SearchRepo({required this.client});

  Future<Searchlist> getSearch(String keyword) async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:5000/api/ECAPP/customer/search/$keyword',
      );
      final res = await client.get(url);
      if (res.statusCode == 400) {
        throw NoDataException();
      }
      if (res.statusCode == 200) {
        return Searchlist.fromJson(jsonDecode(res.body));
      } else {
        throw Exception();
      }
    } catch (e) {
      rethrow;
    }
  }
}
