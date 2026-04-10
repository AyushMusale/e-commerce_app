import 'package:ecapp/presentation/bloc/events/searchevent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ecapp/data/models/product.dart';
import 'package:ecapp/presentation/bloc/bloc/searchbloc.dart';
import 'package:ecapp/presentation/bloc/state/searchstate.dart';

class Searchresultpage extends StatefulWidget {
  final String keyword;
  const Searchresultpage({super.key, required this.keyword});

  @override
  State<Searchresultpage> createState() => _SearchresultpageState();
}

class _SearchresultpageState extends State<Searchresultpage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.keyword;
    context.read<Searchbloc>().add(SearchProductEvent(keyword: widget.keyword));
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('ECAPP')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocListener<Searchbloc, SearchState>(
          listener: (context, state) {
            if (state.message == 'unauthenticated') {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Login expired')));
              context.pushReplacementNamed('loginpage');
            }
          },
          child: Column(
            children: [
              Container(
                height: dh * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          label: Text(
                            "Search",
                            style: TextStyle(color: Colors.black54),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<Searchbloc>().add(
                          SearchProductEvent(keyword: searchController.text.trim()),
                        );
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<Searchbloc, SearchState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.message == 'no data' ||
                        state.searchlist.product.isEmpty) {
                      return const Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    if (state.error == true) {
                      return Center(
                        child: Text(
                          state.message ?? 'Something went wrong',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    final products = state.searchlist.product;
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return _SearchProductCard(product: product);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchProductCard extends StatelessWidget {
  final Product product;
  const _SearchProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          'customerproductpage',
          pathParameters: {'id': product.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  product.images.isNotEmpty ? product.images.first : '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder:
                      (_, __, ___) => const Center(
                        child: Icon(Icons.image_not_supported_outlined),
                      ),
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
              child: Text(
                'Rs ${product.price.toStringAsFixed(0)}',
                style: const TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
