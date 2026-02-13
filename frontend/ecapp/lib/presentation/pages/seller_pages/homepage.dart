import 'package:flutter/material.dart';

class SellerHomepage extends StatefulWidget {
  const SellerHomepage({super.key});

  @override
  State<SellerHomepage> createState() => _SellerHomepageState();
}

class _SellerHomepageState extends State<SellerHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to the Home page"),
      ),
    );
  }
}