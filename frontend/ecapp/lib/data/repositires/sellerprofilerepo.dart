import 'dart:convert';
import 'package:ecapp/data/local_data/sellerprofiledata.dart';
import 'package:ecapp/data/local_data/sellerprofiledb.dart';
import 'package:ecapp/data/models/sellerprofile.dart';
import 'package:ecapp/data/network/authclient.dart';

class SellerProfileRepo {
  SellerProfileDB sellerProfileDB;
  AuthClient client;
  SellerProfileRepo({required this.client, required this.sellerProfileDB});

  Future<String> execute(SellerProfileModel sellerProfileModel) async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/seller/profile');

      final body = jsonEncode({
        'shop_name': sellerProfileModel.shopName,
        'owner_name': sellerProfileModel.ownerName,
        'phone_no': sellerProfileModel.phoneNo,
        'email': sellerProfileModel.email,
        'shop_address': sellerProfileModel.shopAddress,
        'city': sellerProfileModel.city,
        'pincode': sellerProfileModel.pincode,
      });
      // if (!sellerProfileDB.hasProfile()) {
      final res = await client.post(url, body: body);
      final jsonRes = jsonDecode(res.body);

      if (res.statusCode == 200) {
        SellerProfile resProfile = SellerProfile(
          shopName: jsonRes['shop_name'],
          ownerName: jsonRes["owner_name"],
          phone: jsonRes["phone_no"],
          email: jsonRes["email"],
          address: jsonRes["shop_address"],
          city: jsonRes["city"],
          pincode: jsonRes["pincode"],
        );

        await sellerProfileDB.saveProfile(resProfile);

        return 'success';
      }
      if (res.statusCode == 400) {
        return jsonRes['message'];
      }

      if (res.statusCode == 500) {
        return jsonRes['message'];
      }

      return 'network error';
    } catch (e) {
      return 'error';
    }
    //}
  }
}
