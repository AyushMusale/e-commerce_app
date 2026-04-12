
class Product {
  String id;
  String name;
  List<String> images;
  double price;
  int inStock;
  List<String>? category;

  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.inStock,
    required this.category,
  });

  bool get isInStock => inStock > 0;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      images: List<String>.from(json['images']),
      price: (json['price'] as num).toDouble(),
      inStock: _parseInStock(json['inStock'] ?? json['instock']),
      category: json['category'] != null ? List<String>.from(json['category']) : ['lifestyle'],
    );
  }

  static int _parseInStock(dynamic v) {
    if (v == null) return 10;
    if (v is int) return v < 0 ? 0 : v;
    if (v is num) {
      final i = v.toInt();
      return i < 0 ? 0 : i;
    }
    if (v is bool) return v ? 10 : 0;
    if (v is String) {
      final p = int.tryParse(v);
      if (p != null) return p < 0 ? 0 : p;
    }
    return 10;
  }
}
