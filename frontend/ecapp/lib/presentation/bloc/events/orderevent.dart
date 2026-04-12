import 'package:ecapp/data/models/order.dart';

class Orderevent {}

class VerifyOrderEvent extends Orderevent {
  final VerifiedOrder order;

  VerifyOrderEvent({required this.order});
}

class CreateOrderEvent extends Orderevent {}