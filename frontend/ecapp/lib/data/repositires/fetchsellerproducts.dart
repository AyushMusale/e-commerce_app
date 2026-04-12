import 'dart:convert';
import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/network/authclient.dart';

class FetchSellerProductsRepo {
  final AuthClient client;
  FetchSellerProductsRepo({required this.client});

  Future<List<Product>> execute() async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/seller/products');
      final res = await client.get(url);

      if (res.statusCode == 404) {
        throw NoDataException();
      }

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body) as Map<String, dynamic>;
        final productsJson = (body['products'] ?? []) as List<dynamic>;
        return productsJson
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      throw Exception('failed-to-fetch-seller-products');
    } catch (e) {
      rethrow;
    }
  }
}