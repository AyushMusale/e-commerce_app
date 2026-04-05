import 'package:ecapp/data/models/product.dart';

class Homedata {
  final List<Product> electronics;
  final List<Product> fashion;

  Homedata({
    required this.electronics,
    required this.fashion,
  });

  factory Homedata.fromJson(Map<String,dynamic> json){
    return Homedata(electronics: (json['electronics_items'] as List?)?.map((e)=>Product.fromJson(e)).toList() ??[], fashion: (json['fashion_items'] as List?)?.map((e)=>Product.fromJson(e)).toList()??[]);
  }
}