import 'package:ecapp/data/models/customerprofile.dart';
import 'package:ecapp/data/repositires/customerprofilerepo.dart';

class CustomerProfileUsecase {
  CustomerProfileRepo customerProfileRepo;
  CustomerProfileUsecase({required this.customerProfileRepo});

  Future<String> storeCustomerProfile(CustomerProfile customerprofile) async {
    return await customerProfileRepo.storeCustomerProfile(customerprofile);
  }

  Future<CustomerProfile> getCustomerProfile()async{
    return await customerProfileRepo.getCustomerProfile();
  }
}
