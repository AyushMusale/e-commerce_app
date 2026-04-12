import 'package:ecapp/data/models/order.dart';
import 'package:ecapp/presentation/bloc/bloc/cartbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/orderbloc.dart';
import 'package:ecapp/presentation/bloc/events/cartevent.dart';
import 'package:ecapp/presentation/bloc/events/orderevent.dart';
import 'package:ecapp/presentation/bloc/state/cartstate.dart';
import 'package:ecapp/presentation/bloc/state/orderstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Widget _qtyButton(IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 16),
    ),
  );
}

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  Razorpay? _razorpay;
  Order? _pendingOrderForVerify;

  /// Kept after Razorpay success so verify can be retried if the verify API fails.
  VerifiedOrder? _pendingVerifyRetry;

  @override
  void initState() {
    super.initState();
    context.read<Cartbloc>().add(GetCartEvent());
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onRazorpayPaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _onRazorpayPaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, (_) {});
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  void _onRazorpayPaymentSuccess(PaymentSuccessResponse response) {
    if (!mounted) return;
    final pending = _pendingOrderForVerify;
    if (pending == null) return;
    final paymentId = response.paymentId;
    final signature = response.signature;
    final orderId = response.orderId;
    if (paymentId == null || signature == null) return;
    final verified = VerifiedOrder(
      orderId: pending.orderId,
      razorpayOrderId: orderId ?? pending.razorpayOrderId,
      razorpayPaymentId: paymentId,
      razorpaySignature: signature,
    );
    _pendingVerifyRetry = verified;
    _pendingOrderForVerify = null;
    context.read<OrderBloc>().add(VerifyOrderEvent(order: verified));
  }

  void _onRazorpayPaymentError(PaymentFailureResponse response) {
    if (!mounted) return;
    _pendingOrderForVerify = null;
    _pendingVerifyRetry = null;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.message ?? 'Payment failed')),
    );
  }

  void _openRazorpay(Order order) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opening payment...')));
    _pendingOrderForVerify = order;
    _razorpay!.open({
      'key': order.razorpayKey,
      'amount': order.totalAmountPaise,
      'currency': 'INR',
      'name': 'ECAPP',
      'description': 'Order checkout',
      'order_id': order.razorpayOrderId,
    });
  }

  bool _orderFlowLoading(Orderstate s) {
    if (s is CreateOrderState) return s.isLoading;
    if (s is VerifyOrderState) return s.isLoading;
    return false;
  }

  bool _showVerifyRetryFallback(Orderstate s) {
    return s is VerifyOrderState &&
        !s.isLoading &&
        s.error &&
        _pendingVerifyRetry != null;
  }

  void _retryVerifyPayment() {
    final payload = _pendingVerifyRetry;
    if (payload == null || !mounted) return;
    context.read<OrderBloc>().add(VerifyOrderEvent(order: payload));
  }

  Future<void> _refreshCart(BuildContext context) async {
    final bloc = context.read<Cartbloc>();
    bloc.add(GetCartEvent());
    await bloc.stream.firstWhere((s) => !s.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('ECAPP', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<OrderBloc, Orderstate>(
        listener: (context, orderState) {
          if (orderState is CreateOrderState) {
            if (orderState.isLoading) {
              _pendingVerifyRetry = null;
            }
            if (orderState.message == 'unauthenticated') {
              context.pushReplacementNamed('loginpage');
              return;
            }
            if (!orderState.isLoading && !orderState.error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(orderState.message!)));
            }
            if (!orderState.isLoading &&
                !orderState.error &&
                orderState.order != null &&
                orderState.message == 'success') {
              _openRazorpay(orderState.order!);
            }
          }
          if (orderState is VerifyOrderState) {
            if (orderState.message == 'unauthenticated') {
              context.pushReplacementNamed('loginpage');
              return;
            }
            if (!orderState.isLoading &&
                !orderState.error &&
                orderState.message == 'success') {
              _pendingVerifyRetry = null;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful')),
              );
              context.read<Cartbloc>().add(GetCartEvent());
            }
            if (!orderState.isLoading &&
                orderState.error &&
                orderState.message != null) {
              final messenger = ScaffoldMessenger.of(context);
              messenger.hideCurrentSnackBar();
              if (_pendingVerifyRetry != null) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      '${orderState.message} — confirmation failed; your payment may have succeeded.',
                    ),
                    duration: const Duration(minutes: 1),
                    action: SnackBarAction(
                      label: 'Retry',
                      onPressed: _retryVerifyPayment,
                    ),
                  ),
                );
              } else {
                messenger.showSnackBar(
                  SnackBar(content: Text(orderState.message!)),
                );
              }
            }
          }
        },
        builder: (context, orderState) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_showVerifyRetryFallback(orderState))
                    Material(
                      color: Colors.amber.shade50,
                      elevation: 1,
                      child: ListTile(
                        leading: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber.shade900,
                        ),
                        title: const Text('Confirmation pending'),
                        subtitle: const Text(
                          'Your payment may have gone through. Retry to sync with the server.',
                        ),
                        trailing: TextButton(
                          onPressed:
                              _orderFlowLoading(orderState)
                                  ? null
                                  : _retryVerifyPayment,
                          child: const Text('Retry'),
                        ),
                      ),
                    ),
                  Expanded(
                    child: BlocConsumer<Cartbloc, CartState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state.message == 'unauthenticated') {
                          context.pushReplacementNamed('loginpage');
                        }
                        if (state.isLoading == true ||
                            state is CartInititalState) {
                          return RefreshIndicator(
                            onRefresh: () => _refreshCart(context),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.35,
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (state.cart.cartItems.isEmpty) {
                          return RefreshIndicator(
                            onRefresh: () => _refreshCart(context),
                            child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.45,
                                  child: const Center(
                                    child: Text('No Items in Cart'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          final cart = state.cart;
                          final cartItems = cart.cartItems;
                          double totalPrice = cartItems.fold(
                            0,
                            (sum, item) =>
                                sum + (item.product.price * item.quantity),
                          );
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: RefreshIndicator(
                                    onRefresh: () => _refreshCart(context),
                                    child: ListView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount: cartItems.length,
                                      itemBuilder: (context, index) {
                                        final currentItem = cartItems[index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          height: dh * 0.14,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  currentItem
                                                      .product
                                                      .images
                                                      .first,
                                                  height: dh * 0.10,
                                                  width: dh * 0.10,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),

                                              const SizedBox(width: 12),

                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      currentItem.product.name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),

                                                    const SizedBox(height: 6),
                                                    Text(
                                                      "₹${currentItem.product.price}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                      ),
                                                    ),

                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        _qtyButton(Icons.remove, () {
                                                          context.read<Cartbloc>().add(
                                                            RemoveFromCartevent(
                                                              product:
                                                                  currentItem
                                                                      .product,
                                                            ),
                                                          );
                                                        }),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 8,
                                                              ),
                                                          child: Text(
                                                            currentItem.quantity
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                ),
                                                          ),
                                                        ),
                                                        _qtyButton(Icons.add, () {
                                                          context
                                                              .read<Cartbloc>()
                                                              .add(
                                                                AddToCartevent(
                                                                  product:
                                                                      currentItem
                                                                          .product,
                                                                  quantity: 1,
                                                                ),
                                                              );
                                                        }),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  context.read<Cartbloc>().add(
                                                    DeleteFromCartEvent(
                                                      id:
                                                          currentItem
                                                              .product
                                                              .id,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          offset: Offset(0, -2),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Total",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              "₹$totalPrice",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed:
                                              _orderFlowLoading(orderState)
                                                  ? null
                                                  : () {
                                                    context
                                                        .read<OrderBloc>()
                                                        .add(
                                                          CreateOrderEvent(),
                                                        );
                                                  },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            backgroundColor: Colors.orange,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            elevation: 2,
                                          ),
                                          child: const Text(
                                            "Pay Now",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              if (_orderFlowLoading(orderState))
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
