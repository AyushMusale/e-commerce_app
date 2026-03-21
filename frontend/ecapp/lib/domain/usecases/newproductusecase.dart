

import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/data/repositires/newproductrepo.dart';

class Newproductusecase {
  final Newproductrepo newproductrepo;

  Newproductusecase(this.newproductrepo);

  Future<bool> execute(Product product){
    return newproductrepo.execute(product);
  }

}