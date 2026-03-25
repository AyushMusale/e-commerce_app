import 'package:hive/hive.dart';

part 'sellerprofiledata.g.dart';

@HiveType(typeId: 0)
class SellerProfile extends HiveObject {

  @HiveField(0)
  String shopName;

  @HiveField(1)
  String ownerName;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String email;

  @HiveField(4)
  String address;

  @HiveField(5)
  String city;

  @HiveField(6)
  String pincode;

  SellerProfile({
    required this.shopName,
    required this.ownerName,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.pincode,
  });
}