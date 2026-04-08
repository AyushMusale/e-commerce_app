import 'package:ecapp/data/models/cart.dart';

class CartState {
  final Cart cart;
  final bool isLoading;
  final String? message;
  final bool? error;

  CartState({
    required this.cart,
    this.isLoading = false,
    this.message,
    this.error,
  });

  CartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? message,
    bool? error,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
      message: message,
      error: error??false,
    );
  }
}


class CartInititalState extends CartState {
  CartInititalState() : super(cart: Cart(cartItems: []));
}
