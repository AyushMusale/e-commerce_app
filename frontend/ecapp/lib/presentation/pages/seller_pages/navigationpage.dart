import 'package:ecapp/presentation/pages/seller_pages/homepage.dart';
import 'package:ecapp/presentation/pages/seller_pages/productspage.dart';
import 'package:flutter/material.dart';

class SellerNavigationpage extends StatefulWidget {
  const SellerNavigationpage({super.key});

  @override
  State<SellerNavigationpage> createState() => _SellerNavigationpageState();
}

class _SellerNavigationpageState extends State<SellerNavigationpage> {
    final List<dynamic> pages = [SellerHomepage(), SellerProductpage()];
    int currrentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currrentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currrentindex,
        onTap: (index){
          setState(()=> currrentindex = index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp), label: 'Products'),
        ],
      ),
    );
  }
}
