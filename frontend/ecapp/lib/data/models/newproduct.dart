import 'dart:io';

class NewProduct{
  String name;
  String price;
  List<String> category;
  int inStock;
  List<File> images;
  NewProduct({required this.name, required this.price, required this.category, required this.inStock, required this.images});

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