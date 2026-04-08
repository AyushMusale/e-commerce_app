import 'dart:convert';

import 'package:ecapp/data/models/cart.dart';
import 'package:ecapp/data/models/cartitems.dart';
import 'package:ecapp/data/network/authclient.dart';

class CartRepo {
  AuthClient clinet;
  CartRepo({required this.clinet});

  Future<String> updateCart(Cart cart) async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:5000/api/ECAPP/customer/cart',
      ); //http://10.0.2.2:5000/api/ECAPP/customer/home
      Object body = jsonEncode({
        'cart_items':
            cart.cartItems.map((items) {
              return {'product': items.product.id, 'quantity': items.quantity};
            }).toList(),
      });

      final res = await clinet.post(url, body: body);
      if (res.statusCode == 500) {
        throw Exception('Server Error');
      }
      if (res.statusCode == 400) {
        throw Exception('Cart is Empty');
      }
      return 'Success';
    } catch (e) {
      rethrow;
    }
  }

  Future<Cart> getCart() async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/customer/cart');

      final res = await clinet.get(url);
      if (res.statusCode == 500) {
        throw Exception('Server Error');
      }
      final jsonRes = jsonDecode(res.body);
      if (jsonRes['message'] == 'success') {
        final items =
            (jsonRes['cart_items'] as List).map((item) {
              return CartItem.fromJson(item);
            }).toList();
        Cart cart = Cart(cartItems: items);
        return cart;
      } else {
        throw Exception('No Items in Cart');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Cart> deleteFromCart(String id) async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/customer/cart/$id');
      final res = await clinet.delete(url);
      if (res.statusCode != 200) {
        final jsonRes = jsonDecode(res.body);
        throw Exception(jsonRes['message']);
      }
      final jsonRes = jsonDecode(res.body);

      final items =
          (jsonRes['cart_items'] as List).map((item) {
            return CartItem.fromJson(item);
          }).toList();
      Cart cart = Cart(cartItems: items);
      return cart;
    } catch (e) {
      rethrow;
    }
  }
}
