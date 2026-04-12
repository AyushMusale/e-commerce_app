import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/presentation/bloc/bloc/fetchsellerproductbloc.dart';
import 'package:ecapp/presentation/bloc/events/fetchsellerproductevent.dart';
import 'package:ecapp/presentation/bloc/state/fetchsellerproductstate.dart';

class SellerProductpage extends StatefulWidget {
  const SellerProductpage({super.key});

  @override
  State<SellerProductpage> createState() => _SellerProductpageState();
}

class _SellerProductpageState extends State<SellerProductpage> {
  @override
  void initState() {
    context.read<FetchSellerProductBloc>().add(GetSellerProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<FetchSellerProductBloc, FetchSellerProductState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            if (state.error == true) {
              return Center(
                child: Text(state.message ?? "Failed to fetch products"),
              );
            }

            if (state.products.isEmpty || state.message == "no data") {
              return const Center(
                child: Text(
                  "No products yet",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<FetchSellerProductBloc>().add(GetSellerProductsEvent());
              },
              child: GridView.builder(
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return _SellerProductCard(product: product);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        context.pushNamed("productformpage");
      }, label: Text("Add product")),
    );
  }
}

class _SellerProductCard extends StatelessWidget {
  final Product product;
  const _SellerProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                product.images.isNotEmpty ? product.images.first : "",
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported_outlined)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text("Rs ${product.price.toStringAsFixed(0)}"),
          ),
        ],
      ),
    );
  }
}