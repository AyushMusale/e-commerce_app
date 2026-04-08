import 'package:ecapp/data/models/product.dart';

class Fetchproductstate {}


class FetchproductSuccessstate extends Fetchproductstate{
  Product product;
  FetchproductSuccessstate({
    required this.product
  });
}
class FetchproductFailurestate extends Fetchproductstate{
  final String message;
  FetchproductFailurestate({
    required this.message,
  });
}
class FetchproductLoadingstate extends Fetchproductstate{}
class FetchproductInitialstate extends Fetchproductstate{}
