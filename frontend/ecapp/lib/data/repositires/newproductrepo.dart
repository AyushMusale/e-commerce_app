import 'dart:convert';
import 'package:ecapp/data/exceptions/authexception.dart';
import 'package:ecapp/data/local_data/local_data.dart';
import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/network/authclient.dart';
import 'package:http/http.dart' as http;

class Newproductrepo {
  AuthClient authClient;
  AuthDB authDB;
  Newproductrepo({required this.authDB, required this.authClient});
  Future<bool> execute(Product product) async {
    final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/seller/addproduct");
    final accessToken = authDB.getAccessToken();
    final refreshToken = authDB.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      throw UnauthenticatedException();
    }

    var req = http.MultipartRequest('POST', url);

    req.headers['Authorization'] = 'Bearer $accessToken';
    req.fields['name'] = product.name;
    req.fields['price'] = product.price;
    req.fields['category'] = jsonEncode(product.category);
    req.fields['instock'] = jsonEncode(product.inStock);

    for (var images in product.images) {
      req.files.add(await http.MultipartFile.fromPath('images', images.path));
    }
    try {
      var multipartRes = await authClient.multipartrRequest(req);
      var res = await http.Response.fromStream(multipartRes);
      if (res.statusCode == 201) {
        return true;
      }

      if (res.statusCode == 400) {
        return false;
      }
    } catch (e) {
        if(e is RefreshTokenExpiredException){
          rethrow;
        }
        rethrow;
    }

    return false;
  }
}
