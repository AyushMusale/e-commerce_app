import 'package:ecapp/data/models/sellerprofile.dart';
import 'package:ecapp/data/repositires/sellerprofilerepo.dart';

class SellerProfileUsecase{
  SellerProfileRepo sellerProfileRepo;
  SellerProfileUsecase({
    required this.sellerProfileRepo
  });

  Future<String> execute(SellerProfileModel sellerProfileModel){
    return sellerProfileRepo.execute(sellerProfileModel);
  }
}