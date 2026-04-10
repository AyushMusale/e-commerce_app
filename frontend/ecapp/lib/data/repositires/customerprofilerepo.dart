import 'dart:convert';

import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/customerprofile.dart';
import 'package:ecapp/data/network/authclient.dart';

class CustomerProfileRepo {
  AuthClient client;
  CustomerProfileRepo({required this.client});

  Future<String> storeCustomerProfile(CustomerProfile customerprofile) async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/customer/profile');
      Object body = jsonEncode({
        'last_name': customerprofile.lastName,
        'first_name': customerprofile.firstName,
        'email': customerprofile.email,
        'address': customerprofile.address,
        'city': customerprofile.city,
        'phone_no': customerprofile.phoneNo,
        'pincode': customerprofile.pincode,
      });

      final res = await client.post(url, body: body);
      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['message']);
      }

      return 'success';
    } catch (e) {
      rethrow;
    }
  }

  Future<CustomerProfile> getCustomerProfile() async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/customer/profile');
      final res = await client.get(url);
      if (res.statusCode != 200 && res.statusCode!=404) {
        throw Exception(res.statusCode);
      }
      if(res.statusCode == 404){
        throw NoDataException();
      }
      return CustomerProfile.fromJson(jsonDecode(res.body));
    } catch (r) {
      rethrow;
    }
  }
}
