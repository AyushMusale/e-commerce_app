import 'package:ecapp/data/models/bankdetails.dart';
import 'package:ecapp/data/repositires/sellerbankdetailsrepo.dart';

class SellerBankdetailsusecase {
  Sellerbankdetailsrepo sellerbankdetailsrepo;
  SellerBankdetailsusecase({
    required this.sellerbankdetailsrepo
  });

  Future<String> storeDetails(Bankdetails bankdetails) async{
    return await sellerbankdetailsrepo.storeDetails(bankdetails);
  }

  Future<Bankdetails> getDetails()async{
    return await sellerbankdetailsrepo.getDetails();
  }
}