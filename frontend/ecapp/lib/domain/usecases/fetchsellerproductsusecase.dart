import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/repositires/fetchsellerproducts.dart';

class FetchSellerProductsUsecase {
  final FetchSellerProductsRepo fetchSellerProductsRepo;
  FetchSellerProductsUsecase({required this.fetchSellerProductsRepo});

  Future<List<Product>> execute() async {
    return await fetchSellerProductsRepo.execute();
  }
}
