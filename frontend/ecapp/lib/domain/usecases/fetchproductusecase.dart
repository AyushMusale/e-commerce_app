import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/repositires/fetchproductrepo.dart';

class Fetchproductusecase {
  FetchproductRepo fetchproductRepo;
  Fetchproductusecase({
    required this.fetchproductRepo
  });

  Future<Product> execute(String id)async{
    return await fetchproductRepo.execute(id);
  }
}