import 'dart:convert';

import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/network/authclient.dart';

class FetchproductRepo {
  AuthClient client;
  FetchproductRepo({required this.client});

  Future<Product> execute(String id) async {
    try {
      final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/customer/product/$id");
      var res = await client.get(url);
      if (res.statusCode == 400) {
        throw Exception(jsonDecode(res.body)['message']);
      }
      if (res.statusCode == 404) {
        throw Exception(jsonDecode(res.body)['message']);
      }
      if (res.statusCode == 500) {
        throw Exception(jsonDecode(res.body)['message']);
      }
      
      Product product = Product.fromJson(jsonDecode(res.body)['product']);
      return product;
    } catch (e) {
      rethrow;
    }
  }
}