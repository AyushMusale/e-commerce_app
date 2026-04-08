import 'package:ecapp/data/models/cartitems.dart';

class Cart {
  List<CartItem> cartItems;
  Cart({required this.cartItems});

  Cart copyWith({List<CartItem>? cartItems}) {
    return Cart(cartItems: cartItems ?? this.cartItems);
  }
}
