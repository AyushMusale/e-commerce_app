import 'dart:io';

class Product{
  String name;
  String price;
  List<String> category;
  bool inStock;
  List<File> images;
  Product({required this.name, required this.price, required this.category, required this.inStock, required this.images});

  String getName(){
    return name;
  }
  String getPrice(){
    return price;
  }
  List<String> getCateogory(){
    return category;
  }
}