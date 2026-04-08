import 'package:ecapp/data/models/product.dart';

class CartItem{
  Product product;
  int quantity;
  CartItem({
    required this.product,
    required this.quantity
  });

  CartItem copyWith({int? quantity}){
    return CartItem(product: product, quantity: quantity??this.quantity);
  }

  factory CartItem.fromJson(Map<String,dynamic> json){
    return CartItem(product: Product.fromJson(json['product']), quantity: json['quantity']);
  }
}