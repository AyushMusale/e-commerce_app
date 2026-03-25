import 'package:ecapp/data/local_data/sellerprofiledata.dart';
import 'package:hive_flutter/adapters.dart';

class SellerProfileDB {
  final Box<SellerProfile> box = Hive.box<SellerProfile>('sellerProfileDB');


  Future<void> saveProfile(SellerProfile profile) async {
    await box.put('profile', profile);
  }

  SellerProfile? getProfile() {
    return box.get('profile');
  }

  bool hasProfile() {
    return box.containsKey('profile');
  }
}