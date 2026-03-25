import 'package:ecapp/data/local_data/sellerprofiledata.dart';

class SellerProfilestate {}

class SellerProfileInitialState extends SellerProfilestate{}

class SellerProfilePendingState extends SellerProfilestate{}

class SellerProfileLoadedState extends SellerProfilestate{
  SellerProfile sellerProfile;
  String message;
  SellerProfileLoadedState({
    required this.message,
    required this.sellerProfile,
  });
}

class SellerProfileFailureState extends SellerProfilestate{
  String message;
  SellerProfileFailureState({
    required this.message
  });
}

class SellerProfileSuccessState extends SellerProfilestate{
  String message;
  SellerProfileSuccessState({
    required this.message
  });
}