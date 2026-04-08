import 'package:ecapp/data/models/product.dart';

class Cartevent {}

class AddToCartevent extends Cartevent {
  Product product;
  int quantity;
  AddToCartevent({required this.product, required this.quantity});
}

class RemoveFromCartevent extends Cartevent {
  Product product;
  bool? delete;
  RemoveFromCartevent({required this.product,  this.delete});
}

class GetCartEvent extends Cartevent{}

class DeleteFromCartEvent extends Cartevent{
  String id;
  DeleteFromCartEvent({
    required this.id
  });
}