import 'dart:convert';

import 'package:ecapp/data/exceptions/generalpurposeexception.dart';
import 'package:ecapp/data/models/order.dart';
import 'package:ecapp/data/network/authclient.dart';

class CreateOrderRepo {
  AuthClient client;
  CreateOrderRepo({required this.client});

  Future<Order> createOrder() async {
    try {
      final url = Uri.parse('http://10.0.2.2:5000/api/ECAPP/customer/order');
      final res = await client.post(url);
      if (res.statusCode == 400) {
        throw NoDataException.setException(jsonDecode(res.body)['message']);
      }
      if (res.statusCode == 200) {
        final map = jsonDecode(res.body) as Map<String, dynamic>;
        if (map['message'] == 'existing-order') {
          return Order.fromJson(map);
        }
        throw Exception(map['message']?.toString() ?? 'order failed');
      }
      if (res.statusCode != 201) {
        throw Exception(jsonDecode(res.body)['message']);
      }
      return Order.fromJson(jsonDecode(res.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<VerifiedOrder> verifyOrder(
    VerifiedOrder order,
  ) async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:5000/api/ECAPP/customer/verify-payment',
      );
      final res = await client.post(
        url,
        body: jsonEncode({
          'order_id': order.orderId,
          'razorpay_payment_id': order.razorpayPaymentId,
          'razorpay_signature': order.razorpaySignature,
          'razorpay_order_id': order.razorpayOrderId,
        }),
      );

      if (res.statusCode != 200) {
        throw Exception(jsonDecode(res.body)['message']);
      }
      return VerifiedOrder.fromJson(jsonDecode(res.body));
    } catch (e) {
      rethrow;
    }
  }
}
