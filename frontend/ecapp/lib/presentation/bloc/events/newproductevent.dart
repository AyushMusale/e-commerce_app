
import 'package:ecapp/data/models/product.dart';

class Newproductevent {}

class Newproductaddrequest extends Newproductevent {
  final Product product;
  Newproductaddrequest(this.product);
}
