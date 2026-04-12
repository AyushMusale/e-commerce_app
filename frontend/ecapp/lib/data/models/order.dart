class Order {
  String orderId;
  String totalAmount;
  int totalAmountPaise;
  String razorpayOrderId;
  String razorpayKey;
  String paymentStatus;

  Order({
    required this.orderId,
    required this.paymentStatus,
    required this.razorpayKey,
    required this.razorpayOrderId,
    required this.totalAmount,
    required this.totalAmountPaise,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final rupees = json['total_amount'];
    final paise = json['total_amount_paise'];
    final parsedPaise = _readInt(paise);
    final parsedRupees = _readDouble(rupees);
    final amountPaise = parsedPaise ??
        (parsedRupees != null ? (parsedRupees * 100).round() : 0);

    return Order(
      orderId: json['order_id']?.toString() ?? '',
      paymentStatus: json['payment_status']?.toString() ?? 'pending',
      razorpayKey: json['razorpay_key']?.toString() ?? '',
      razorpayOrderId: json['razorpay_order_id']?.toString() ?? '',
      totalAmount: rupees?.toString() ?? '0',
      totalAmountPaise: amountPaise,
    );
  }

  static int? _readInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.round();
    return int.tryParse(v.toString());
  }

  static double? _readDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }
}

class VerifiedOrder {
  String orderId;
  String razorpayOrderId;
  String razorpayPaymentId;
  String razorpaySignature;

  VerifiedOrder({
    required this.orderId,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
  });

  factory VerifiedOrder.fromJson(Map<String, dynamic> json) {
    return VerifiedOrder(
      orderId: json['order_id']?.toString() ?? '',
      razorpayOrderId: json['razorpay_order_id']?.toString() ?? '',
      razorpayPaymentId: json['razorpay_payment_id']?.toString() ?? '',
      razorpaySignature: json['razorpay_signature']?.toString() ?? '',
    );
  }
}
