import 'package:ecapp/data/models/product.dart';

class Searchlist {
  List<Product> product;
  Searchlist({required this.product});

  factory Searchlist.fromJson(dynamic json) {
    // Backend currently returns a raw list: [ {...product}, {...product} ]
    // Keep map fallback for compatibility if response shape changes.
    final List<dynamic> rawList =
        json is List
            ? json
            : (json is Map<String, dynamic> ? (json['products'] ?? []) : []);

    return Searchlist(
      product:
          rawList
              .map((item) => Product.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}