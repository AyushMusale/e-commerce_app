import 'dart:convert';

import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/bankdetails.dart';
import 'package:ecapp/data/network/authclient.dart';

class Sellerbankdetailsrepo {
  AuthClient client;
  Sellerbankdetailsrepo({required this.client});

  Future<String> storeDetails(Bankdetails bankdetails) async {
    try {
      final url = Uri.parse('http:10.0.2.2:5000/api/ECAPP/seller/bankdetails');
      Object body = jsonEncode({
        'account_holder_name': bankdetails.accountholderName,
        'account_number': bankdetails.accountNummber,
        'ifsc': bankdetails.ifsc,
      });

      final res = await client.post(url, body: body);
      if (res.statusCode != 200) {
        final jsonRes = jsonDecode(res.body);
        throw Exception(jsonRes['message']);
      }
      final jsonRes = jsonDecode(res.body);
      return jsonRes['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Bankdetails> getDetails() async {
    try {
      final url = Uri.parse("http://10.0.2.2:5000/api/ECAPP/seller/bankdetails");
      final res = await client.get(url);
      if (res.statusCode != 200 && res.statusCode != 404) {
        final jsonRes = jsonDecode(res.body);
        throw Exception(jsonRes['message']);
      }
      if (res.statusCode == 200 && jsonDecode(res.body)['message'] != 'success') {
        throw NoDataException();
      }
      final jsonRes = jsonDecode(res.body);
      return await jsonRes['bank_details'];
    } catch (e) {
      rethrow;
    }
  }
}
