import 'package:ecapp/data/models/sellerprofile.dart';

class SellerProfileEvent {}

class SellerProfileGetDataEvent extends SellerProfileEvent{}

class SellerCreateProfileEvent extends SellerProfileEvent{
  SellerProfileModel sellerProfile;
  SellerCreateProfileEvent({
    required this.sellerProfile,
  });
}