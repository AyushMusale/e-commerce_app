import 'package:ecapp/data/models/homedata.dart';
import 'package:ecapp/data/repositires/customerhomepagereppo.dart';

class GetCustomerHomepageDataUsecase{
  GetCustomerHomepageDataRepo getCustomerHomepageDataRepo;
  GetCustomerHomepageDataUsecase({
    required this.getCustomerHomepageDataRepo,
  });

  Future<Homedata> execute()async{
    return await getCustomerHomepageDataRepo.execute();
  }
}