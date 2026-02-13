import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SellerProductpage extends StatefulWidget {
  const SellerProductpage({super.key});

  @override
  State<SellerProductpage> createState() => _SellerProductpageState();
}

class _SellerProductpageState extends State<SellerProductpage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("Welcome to the Products page"),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        context.pushNamed("productformpage");
      }, label: Text("Add product")),
    );
  }
}