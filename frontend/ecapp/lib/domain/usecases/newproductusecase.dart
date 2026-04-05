

import 'package:ecapp/data/models/newproduct.dart';
import 'package:ecapp/data/repositires/newproductrepo.dart';

class Newproductusecase {
  final Newproductrepo newproductrepo;

  Newproductusecase(this.newproductrepo);

  Future<bool> execute(NewProduct product){
    return newproductrepo.execute(product);
  }

}