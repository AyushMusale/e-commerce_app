
class Product {
  String id;
  String name;
  List<String> images;
  double price;
  bool? instock;
  List<String>? category;

  Product({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.instock,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      images: List<String>.from(json['images']),
      price: (json['price'] as num).toDouble(),
      instock: json['instock']?? true,
      category: json['category'] != null ? List<String>.from(json['category']) : ['lifestyle'],
    );
  }
}
