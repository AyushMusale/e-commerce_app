import 'package:ecapp/data/models/order.dart';

class Orderstate {}

class  OrderInitialState extends Orderstate{}

class CreateOrderState extends Orderstate {
  final Order? order;
  final bool isLoading;
  final String? message;
  final bool error;

  CreateOrderState({
    this.order,
    this.isLoading = false,
    this.message,
    this.error = false,
  });

  CreateOrderState copyWith({
    Order? order,
    bool? isLoading,
    String? message,
    bool? error,
  }) {
    return CreateOrderState(
      order: order ?? this.order,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class VerifyOrderState extends Orderstate {
  final VerifiedOrder? verifiedOrder;
  final bool isLoading;
  final String? message;
  final bool error;

  VerifyOrderState({
    this.verifiedOrder,
    this.isLoading = false,
    this.message,
    this.error = false,
  });

  VerifyOrderState copyWith({
    VerifiedOrder? verifiedOrder,
    bool? isLoading,
    String? message,
    bool? error,
  }) {
    return VerifyOrderState(
      verifiedOrder: verifiedOrder ?? this.verifiedOrder,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

