import 'package:ecapp/data/models/cart.dart';
import 'package:ecapp/data/repositires/cartrepo.dart';

class CartUsecase {
  CartRepo cartRepo;
  CartUsecase({required this.cartRepo});

  Future<String> updateCart(Cart cart) async {
    return await cartRepo.updateCart(cart);
  }

  Future<Cart> getCart() async {
    return await cartRepo.getCart();
  }

  Future<Cart> deletefromCart(String id) async{
    return await cartRepo.deleteFromCart(id);
  }
}
