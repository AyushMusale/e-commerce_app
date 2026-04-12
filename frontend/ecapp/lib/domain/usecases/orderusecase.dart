import 'package:ecapp/data/models/order.dart';
import 'package:ecapp/data/repositires/orderrepo.dart';

class Orderusecase {
  CreateOrderRepo createOrderRepo;
  Orderusecase({required this.createOrderRepo});

  Future<Order> createOrder() async {
    try {
      return await createOrderRepo.createOrder();
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifiedOrder> verifyOrder(
    VerifiedOrder order,
  ) async {
    try {
      return await createOrderRepo.verifyOrder(
        order
      );
    } catch (e) {
      rethrow;
    }
  }
}
