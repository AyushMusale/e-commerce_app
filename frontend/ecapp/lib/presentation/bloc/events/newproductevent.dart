
import 'package:ecapp/data/models/newproduct.dart';

class Newproductevent {}

class Newproductaddrequest extends Newproductevent {
  final NewProduct product;
  Newproductaddrequest(this.product);
}
