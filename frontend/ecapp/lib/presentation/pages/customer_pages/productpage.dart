import 'package:ecapp/data/models/cartitems.dart';
import 'package:ecapp/presentation/bloc/bloc/cartbloc.dart';
import 'package:ecapp/presentation/bloc/bloc/fetchproductbloc.dart';
import 'package:ecapp/presentation/bloc/events/cartevent.dart';
import 'package:ecapp/presentation/bloc/events/fetchproductevent.dart';
import 'package:ecapp/presentation/bloc/state/cartstate.dart';
import 'package:ecapp/presentation/bloc/state/fetchproductstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Productpage extends StatefulWidget {
  final String id;
  const Productpage({super.key, required this.id});

  @override
  State<Productpage> createState() => _ProductpageState();
}

class _ProductpageState extends State<Productpage> {
  @override
  void initState() {
    context.read<Fetchproductbloc>().add(FetchproductDataevent(id: widget.id));
    super.initState();
  }

  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<Fetchproductbloc, Fetchproductstate>(
          listener: (context, state) {
            if (state is FetchproductFailurestate) {
              if (state.message == 'unauthenticated') {
                context.pushReplacementNamed('loginpage');
              }
            }
          },
          builder: (context, state) {
            if (state is FetchproductLoadingstate ||
                state is FetchproductInitialstate) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is FetchproductFailurestate) {
              return Center(child: Text("Couldn't load, try again"));
            }
            final product = (state as FetchproductSuccessstate).product;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: dh * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 199, 59),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange,
                          offset: Offset(3, 3),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                product.images[index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product.images.length,
                              (dotIndex) => Container(
                                height: 12,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    98,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: currentIndex == dotIndex ? 12 : 8,
                                  height: currentIndex == dotIndex ? 12 : 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        currentIndex == dotIndex
                                            ? Colors.white
                                            : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "₹${product.price}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "₹${(product.price * 1.3).toInt()}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    product.instock!
                                        ? Colors.green.shade50
                                        : Colors.red.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                product.instock! ? "In Stock" : "Out of Stock",
                                style: TextStyle(
                                  color:
                                      product.instock!
                                          ? Colors.green
                                          : Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            Icon(
                              product.instock!
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              size: 16,
                              color:
                                  product.instock! ? Colors.green : Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<Cartbloc, CartState>(
                    buildWhen: (prev, current) => prev.cart != current.cart,
                    listener: (context, state) {
                      if (state.error == true) {
                        if (state.message == 'unauthenticated') {
                          context.pushReplacementNamed('loginpage');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message!),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      }
                      if (state.message != null && state.error != true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message!),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      CartItem? cartItem;
                      try {
                        cartItem = state.cart.cartItems.firstWhere(
                          (item) => item.product.id == widget.id,
                        );
                      } catch (e) {
                        cartItem = null;
                      }
                      if (cartItem != null) {
                        return Container(
                          height: dh * 0.06,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ➖ Decrease
                              IconButton(
                                onPressed: () {
                                  context.read<Cartbloc>().add(
                                    RemoveFromCartevent(product: product),
                                  );
                                },
                                icon: const Icon(Icons.remove),
                              ),

                              // Quantity
                              Text(
                                cartItem.quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // ➕ Increase
                              IconButton(
                                onPressed: () {
                                  context.read<Cartbloc>().add(
                                    AddToCartevent(
                                      product: product,
                                      quantity: 1,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: dh * 0.06,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<Cartbloc>().add(
                                AddToCartevent(product: product, quantity: 1),
                              );
                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
