import 'package:ecapp/data/models/product.dart';

class FetchSellerProductState {
  final List<Product> products;
  final bool isLoading;
  final String? message;
  final bool? error;

  FetchSellerProductState({
    required this.products,
    this.isLoading = false,
    this.message,
    this.error,
  });

  FetchSellerProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? message,
    bool? error,
  }) {
    return FetchSellerProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      message: message,
      error: error ?? false,
    );
  }
}

class FetchSellerProductInitialState extends FetchSellerProductState {
  FetchSellerProductInitialState() : super(products: []);
}
